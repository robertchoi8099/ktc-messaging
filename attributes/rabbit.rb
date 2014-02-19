include_attribute 'rabbitmq::default'
include_attribute 'ktc-messaging::openstack'

default['rabbitmq']['tcp_listen_keepalive'] = true
# make every queue as mirrored queue
default['rabbitmq']['policies']['ha-all']['pattern'] = '^(?!amq\\.).*'
default['rabbitmq']['heartbeat'] = 0
default['rabbitmq']['address'] = '0.0.0.0'

# TODO: move this to be using chef-vault
default['rabbitmq']['port'] = node['openstack']['mq']['port']
default['rabbitmq']['default_user'] = node['openstack']['mq']['user']
default['rabbitmq']['default_pass'] = node['openstack']['mq']['user']

default['rabbitmq']['use_distro_version'] = true

# adjust ulimit of open file descriptors
default['rabbitmq']['max_file_descriptors'] = 102_400
