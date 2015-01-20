# Cookbook Name:: stig
# Recipe:: file_permissions
# Author: Ivan Suftin <isuftin@usgs.gov>
#
# Description: File permission configuration 
#
# CIS Benchmark Items
# RHEL6:  6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7, 6.1.8, 6.1.9, 6.1.10, 9.1.1, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8
# CENTOS6: 6.1.3, 6.1.4, 6.1.5, 6.1.6, 6.1.7, 6.1.8, 6.1.9, 6.1.10, 9.1.2, 9.1.3, 9.1.4, 9.1.5, 9.1.6, 9.1.7, 9.1.8, 9.1.9
#
# - Set User/Group Owner and Permission on /etc/anacrontab
# - Set User/Group Owner and Permission on /etc/crontab
# - Set User/Group Owner and Permission on /etc/cron.hourly
# - Set User/Group Owner and Permission on /etc/cron.daily
# - Set User/Group Owner and Permission on /etc/cron.weekly
# - Set User/Group Owner and Permission on /etc/cron.monthly
# - Set User/Group Owner and Permission on /etc/cron.d
# - Restrict at Daemon
# - Verify Permissions on /etc/passwd
# - Verify Permissions on /etc/shadow
# - Verify User/Group Ownership on /etc/passwd
# - Verify User/Group Ownership on /etc/shadow
# - Verify Permissions on /etc/gshadow
# - Verify User/Group Ownership on /etc/gshadow
# - Verify Permissions on /etc/group
# - Verify User/Group Ownership on /etc/group

%w{/etc/anacrontab /etc/crontab}.each do |f|
  file f do
    owner "root"
    group "root"
    mode 0600  
  end
end

%w{/etc/cron.hourly /etc/cron.daily /etc/cron.weekly /etc/cron.monthly /etc/cron.d}.each do |d|
  directory d do
    owner "root"
    group "root"
    mode 0700 
  end
end

%w{/etc/shadow /etc/gshadow}.each do |f|
  file f do
    owner "root"
    group "root"
    mode 0000  
  end
end

%w{/etc/passwd /etc/group}.each do |f|
  file f do
    owner "root"
    group "root"
    mode 0644  
  end
end

file "/etc/at.deny" do
  owner "root"
  group "root"
  mode 0700
end

file "/etc/at.allow" do
  action :delete
end
