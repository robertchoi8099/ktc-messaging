#
# setup monitoring for messaging services
#

# we don't want to load this stuff if we don't have too
return if node[:ktc][:messaging][:monitor] == false
include_recipe 'ktc-monitor::client'

processes = node['openstack']['mq']['mq_processes']

processes.each do |process|
  sensu_check "check_process_#{process['name']}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process['name']}"
    handlers ['default']
    standalone true
    interval 30
  end
end

ktc_collectd_processes 'mq-processes' do
  input processes
end
