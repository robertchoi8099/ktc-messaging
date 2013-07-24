#
# Cookbook Name:: ktc-messaging
# Recipe:: default
#
# Copyright 2013, KT Cloudware, Inc.
#
# All rights reserved - Do Not Redistribute
#

class ::Chef::Recipe
  include ::Openstack
end

iface = node.default["interface_mapping"]["management"]

#node.default["openstack"]["mq"]["server_role"] = "ktc-messaging"
# This attribute tells rabbit which interface to bind to
node.override["openstack"]["mq"]["bind_interface"] = iface

# these attibutes are searched for by openstack-network and openstack-storage 
# to find the rabbit instance 
node.default["queue"]["host"] = address_for iface
node.default["queue"]["port"] = "5672"

# necessary so other node can access those attributes via chef search
node.save

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-ops-messaging::server"
