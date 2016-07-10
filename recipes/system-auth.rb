# Cookbook Name:: stig
# Recipe:: system-auth
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: Configure Sysauth
#
# CIS Benchmark Items
# RHEL6:  6.3.6
# CENTOS6: 6.3.4
# UBUNTU: 9.2.3
#
# - Limit Password Reuse
#
# Checked against CIS RHEL 6 STIG 1.4.0

platform = node['platform']

pass_reuse_limit = node["stig"]["system_auth"]["pass_reuse_limit"]
system_auth_file = "/etc/pam.d/system-auth-ac"

bash 'update_pass_reuse_in_pam_sysauth' do
  code <<-EOF
  # Test if the password reuse line is in /etc/pam.d/system-auth
  grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so' #{system_auth_file}

  if [ $? -eq 0 ]; then
    # Line was in the file. Now test whether it has the remember text in it
    grep -q 'password[[:space:]]*sufficient[[:space:]]*pam_unix.so\(.*\)remember' #{system_auth_file}
    if [ $? -eq 0 ]; then
      # It already has a remember value. Just need to replace it
      sed -i 's/remember=.*/remember=#{pass_reuse_limit}/' #{system_auth_file}
    else
      # Remember limit is not in the file. Append it to the end
      sed -i '/^password[[:space:]]*sufficient[[:space:]]*pam_unix.so/s/$/ remember=#{pass_reuse_limit}/' #{system_auth_file}
      fi
    else
      # Line was not in the file. Add it to the end
      echo 'password    sufficient    pam_unix.so try_first_pass use_authtok nullok sha512 shadow remember=#{pass_reuse_limit}' >> #{system_auth_file}
      fi
    var_accounts_passwords_pam_faillock_deny="3"
    AUTH_FILES[0]="/etc/pam.d/system-auth"
    AUTH_FILES[1]="/etc/pam.d/password-auth"

    for pamFile in "${AUTH_FILES[@]}"
      do

        # pam_faillock.so already present?
        if grep -q "^auth.*pam_faillock.so.*" $pamFile; then

          # pam_faillock.so present, deny directive present?
          if grep -q "^auth.*[default=die].*pam_faillock.so.*authfail.*deny=" $pamFile; then

            # both pam_faillock.so & deny present, just correct deny directive value
            sed -i --follow-symlink "s/\(^auth.*required.*pam_faillock.so.*preauth.*silent.*\)\(deny *= *\).*/\1\2$var_accounts_passwords_pam_faillock_deny/" $pamFile
            sed -i --follow-symlink "s/\(^auth.*[default=die].*pam_faillock.so.*authfail.*\)\(deny *= *\).*/\1\2$var_accounts_passwords_pam_faillock_deny/" $pamFile

            # pam_faillock.so present, but deny directive not yet
          else

            # append correct deny value to appropriate places
            sed -i --follow-symlink "/^auth.*required.*pam_faillock.so.*preauth.*silent.*/ s/$/ deny=$var_accounts_passwords_pam_faillock_deny/" $pamFile
            sed -i --follow-symlink "/^auth.*[default=die].*pam_faillock.so.*authfail.*/ s/$/ deny=$var_accounts_passwords_pam_faillock_deny/" $pamFile
            fi

            # pam_faillock.so not present yet
          else

            # insert pam_faillock.so preauth & authfail rows with proper value of the 'deny' option
            sed -i --follow-symlink "/^auth.*sufficient.*pam_unix.so.*/i auth        required      pam_faillock.so preauth silent deny=$var_accounts_passwords_pam_faillock_deny" $pamFile
            sed -i --follow-symlink "/^auth.*sufficient.*pam_unix.so.*/a auth        [default=die] pam_faillock.so authfail deny=$var_accounts_passwords_pam_faillock_deny" $pamFile
            sed -i --follow-symlink "/^account.*required.*pam_unix.so/i account     required      pam_faillock.so" $pamFile
            fi
            done
            EOF
            only_if { %w{rhel fedora centos}.include? platform }
            not_if "grep -q 'remember=#{pass_reuse_limit}' #{system_auth_file}"
          end

          file '/etc/pam.d/system-auth' do
            action :delete
            not_if 'test -L /etc/pam.d/system-auth'
          end

          link '/etc/pam.d/system-auth' do
            to system_auth_file
            mode '0644'
          end

          template "/etc/pam.d/common-password" do
            source "etc_pam.d_common-password.erb"
            owner "root"
            group "root"
            mode 0644
            variables(
            :pass_reuse_limit => pass_reuse_limit
            )
            only_if { %w{debian ubuntu}.include? platform }
          end
