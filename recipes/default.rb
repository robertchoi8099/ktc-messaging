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
member = Services::Member.new node.fqdn,
  service: "rabbitmq",
  port: 5672,
  proto: "tcp",
  ip: ip

member.save

node.default["openstack"]["mq"]["server_role"] = "ktc-messaging"
# This attribute tells rabbit which interface to bind to
node.override["openstack"]["mq"]["bind_interface"] = iface
if node["ha_disabled"].nil?
  node.override["openstack"]["mq"]["cluster"] = "true"
end

# these attibutes are searched for by openstack-network and openstack-storage 
# to find the rabbit instance 
node.default["queue"]["host"] = ip
node.default["queue"]["port"] = "5672"

# necessary so other node can access those attributes via chef search
node.save

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-ops-messaging::server"
