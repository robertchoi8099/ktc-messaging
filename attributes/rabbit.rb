include_attribute 'rabbitmq::default'
include_attribute 'ktc-messaging::openstack'
include_attribute 'ktc-package'

# our pkg
default['rabbitmq']['package'] = "http://#{node[:repo_host]}/prod/storage/rabbitmq-server_3.1.5-1_all.deb"

default['rabbitmq']['tcp_listen_keepalive'] = true
default['rabbitmq']['heartbeat'] = 0
default['rabbitmq']['address'] = '0.0.0.0'

# TODO: move this to be using chef-vault
default['rabbitmq']['port'] = node['openstack']['mq']['port']
default['rabbitmq']['default_user'] = node['openstack']['mq']['user']
default['rabbitmq']['default_pass'] = node['openstack']['mq']['user']

# adjust ulimit of open file descriptors
default['rabbitmq']['max_file_descriptors'] = 102_400
