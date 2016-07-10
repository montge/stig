#
# Cookbook Name:: stig
# Recipe:: Disable PRELINKING
# Author: Evan Montgomery-Recht <evan.montgomery-recht@va.gov>
#
# Description: Disables Prelinking to support AIDE
#
# - Disables prelinking to allow aide to reduce false alarms

platform = node['platform']

file '/etc/sysconfig/prelink' do
  content 'PRELINKING=no'
  mode '0644'
  owner 'root'
  group 'root'
end
