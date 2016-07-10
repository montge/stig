#
# Cookbook Name:: stig
# Recipe:: modprobe disable USB
# Author: Evan Montgomery-Recht <evan.montgomery-recht@va.gov>
#
# Description: Disables Modprobe for USB Storage
#
# - Disables Modprobe for USB Storage

platform = node['platform']

file '/etc/modprobe.d/no-usb-storage' do
  content 'install usb-storage /bin/true'
  mode '0644'
  owner 'root'
  group 'root'
end
