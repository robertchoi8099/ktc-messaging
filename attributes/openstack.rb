include_attribute 'ktc-utils'
include_attribute 'openstack-common'

default['openstack']['mq']['service_type'] = 'rabbitmq'

# enable/disable cluster based on ha-disabled setting
default['openstack']['mq']['cluster'] = node['ha_disabled'] ? false : true

# process monitoring
default['openstack']['mq']['mq_processes'] = [
  { 'name' => 'rabbitmq-server', 'shortname' => 'rabbitmq-server' },
  { 'name' => 'beam.smp', 'shortname' => 'beam.smp' }
]
default['openstack']['mq']['server_role'] = 'ktc-messaging'
