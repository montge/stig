# Cookbook Name:: stig
# Recipe:: ntpd
# Author: Evan Montgomery-Recht <evan.montgomery-recht@va.gov>
# Description: Adds NTPD servers for time service

package "ntp"

service 'ntpd' do
  pattern 'ntpd'
  action [:enable, :start]
end

template "/etc/ntp.conf" do
  source "etc_ntp.conf.erb"
  mode "0644"
  owner "root"
  group "root"
  variables({
              :servers => node['stig']['ntpd']['servers']
  })
  notifies :restart, "service[ntpd]", :immediately
end
