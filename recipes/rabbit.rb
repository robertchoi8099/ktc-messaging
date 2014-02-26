#
# setup rabbitmq
#

include_recipe 'rabbitmq'
include_recipe 'rabbitmq::mgmt_console'

user = node['rabbitmq']['default_user']
pass = node['rabbitmq']['default_pass']

rabbitmq_user 'remove rabbit guest user' do
  user 'guest'
  action :delete
  not_if { user == 'guest' }
end

rabbitmq_user 'add openstack rabbit user' do
  user user
  password pass
  action :add
end

rabbitmq_user 'change openstack rabbit user password' do
  user user
  password pass
  action :change_password
end

rabbitmq_vhost 'add openstack rabbit vhost' do
  vhost node['openstack']['mq']['vhost']
  action :add
end

rabbitmq_user 'set openstack user permissions' do
  user user
  vhost node['openstack']['mq']['vhost']
  permissions '.* .* .*'
  action :set_permissions
end

# Necessary for graphing.
rabbitmq_user 'set rabbit administrator tag' do
  user user
  tag 'administrator'
  action :set_tags
end

template '/etc/default/rabbitmq-server' do
  source 'rabbitmq-server.default.erb'
  action :create
  notifies :restart, 'service[rabbitmq-server]'
end
