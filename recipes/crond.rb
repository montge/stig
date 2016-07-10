#
# Cookbook Name:: stig
# Recipe:: cron
# Author: Evan Montgomery-Recht <evan.montgomery-recht@va.gov>
#
# Description: Enables Cron per VA CRISP
#
# CIS Benchmark Items
# RHEL6: 1.4.1, 1.4.2
# CENTOS6: 1.3.1, 1.3.2
# UBUNTU: 8.3.1, 8.3.2
# - Install enable and start cron

platform = node['platform']

service 'crond' do
  pattern 'crond'
  action [:enable, :start]
end
