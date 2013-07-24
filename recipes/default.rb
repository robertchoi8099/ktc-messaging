#
# Cookbook Name:: ktc-messaging
# Recipe:: default
#
# Copyright 2013, KT Cloudware, Inc.
#
# All rights reserved - Do Not Redistribute
#

class ::Chef::Recipe
  include ::KTCUtils
end


#node.default["openstack"]["mq"]["server_role"] = "ktc-messaging"
# This attribute tells rabbit which interface to bind to
node.override["openstack"]["mq"]["bind_interface"] = get_interface "management"

# these attibutes are searched for by openstack-network and openstack-storage 
# to find the rabbit instance 
node.override["queue"]["host"] = get_interface_address "management"
node.override["queue"]["port"] = "5672"

# necessary so other node can access those attributes
node.save

include_recipe "openstack-common"
include_recipe "openstack-common::logging"
include_recipe "openstack-ops-messaging::server"
