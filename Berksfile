#
# vim: set ft=ruby:
#
chef_api "https://cookbooks.mkd2.ktc", node_name: "cookbook", client_key: ".cookbook.pem"
site :opscode

metadata

# This cookbook should be used temporarily until the following bug is fixed in upstream.
# https://tickets.opscode.com/browse/COOK-4360
# https://github.com/opscode-cookbooks/rabbitmq/pull/102
cookbook 'rabbitmq', github: 'robertchoi8099/rabbitmq'

group "integration" do
  cookbook "etcd"
  cookbook "ktc-testing"
end
