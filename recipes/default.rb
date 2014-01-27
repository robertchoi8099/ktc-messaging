#
# Cookbook Name:: ktc-messaging
# Recipe:: default
#
# Copyright 2013, KT Cloudware, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "services"
include_recipe "ktc-utils"

iface = KTC::Network.if_lookup "management"
ip = KTC::Network.address "management"

Services::Connection.new run_context: run_context
member = Services::Member.new node["fqdn"],
  service: "rabbitmq",
  port: 5672,
  proto: "tcp",
  ip: ip

member.save

node.default["openstack"]["mq"]["server_role"] = "ktc-messaging"
# This attribute tells rabbit which interface to bind to
node.override["openstack"]["mq"]["bind_interface"] = iface

unless node["ha_disabled"]
  # Override the attr overriden in stackforge cookbook
  # Bind 0.0.0.0 so that rabbit listens to all ipv4 packets heading to the vip
  node.force_override["rabbitmq"]["address"] = "0.0.0.0"

  node.override["openstack"]["mq"]["cluster"] = "true"

  include_recipe "ktc-openstack-ha::rabbitmq"
end

# Use the latest version
# Override the attr overridden in the stackforge cookbook
node.force_override['rabbitmq']['use_distro_version'] = false

# these attibutes are searched for by openstack-network and openstack-storage
# to find the rabbit instance
node.default["queue"]["host"] = ip
node.default["queue"]["port"] = "5672"

# necessary so other node can access those attributes via chef search
node.save

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-ops-messaging::server"

# adjust ulimit of open file descriptors
node.set["rabbitmq"]["max_file_descriptors"] = 102400

template "/etc/default/rabbitmq-server" do
  source "rabbitmq-server.default.erb"
  action :create
  notifies :restart, "service[rabbitmq-server]"
end

# process monitoring and sensu-check config
processes = node['openstack']['mq']['mq_processes']

processes.each do |process|
  sensu_check "check_process_#{process['name']}" do
    command "check-procs.rb -c 10 -w 10 -C 1 -W 1 -p #{process['name']}"
    handlers ["default"]
    standalone true
    interval 30
  end
end

ktc_collectd_processes "mq-processes" do
  input processes
end

include_recipe "rabbitmq::policy_management"
