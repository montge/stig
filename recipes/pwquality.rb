# Cookbook Name:: stig
# Recipe:: pwqality
# Author: Evan Montgomery-Recht <evan.montgomery-recht@va.gov>
#
# Description: Update password quality definitions
#
# CIS Benchmark Items
# RHEL6: 7.2.1, 7.2.2, 7.2.3
# CENTOS6: 7.1.1, 7.1.2, 7.1.3
# UBUNTU: 10.1.1, 10.1.2, 10.1.3
#
# - Set Password Strength Minimum Digit Characters
# - Set Password Minimum Length
# - Set Password Strength Minimum Uppercase Characters
# - Set Password Strength Minimum Special Characters
# - Set Password Strength Minimum Lowercase Characters
# - Set Password Strength Minimum Different Characters

template "/etc/security/pwquality.conf" do
  source "etc_security_pwquality.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
