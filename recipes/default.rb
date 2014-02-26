#
# Cookbook Name:: ktc-messaging
# Recipe:: default
#
# Copyright 2013, KT Cloudware, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'services'
include_recipe 'ktc-utils'

ip = KTC::Network.address 'management'
# these attibutes are searched for by openstack-network and openstack-storage
# to find the rabbit instance
node.default['queue']['host'] = ip
node.default['queue']['port'] = '5672'

Services::Connection.new run_context: run_context
member = Services::Member.new node['fqdn'],
                              service: 'rabbitmq',
                              port: node['queue']['port'].to_i,
                              proto: 'tcp',
                              ip: ip
member.save

include_recipe 'ktc-openstack-ha::rabbitmq' unless node['ha_disabled']
include_recipe 'openstack-common'
include_recipe 'openstack-common::logging'
include_recipe 'ktc-messaging::rabbit'
include_recipe 'ktc-messaging::_monitor'
include_recipe 'rabbitmq::policy_management'
