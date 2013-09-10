#
# vim: set ft=ruby:
#
site :opscode

metadata

cookbook 'ktc-etcd', github: 'cloudware-cookbooks/ktc-etcd', branch: 'develop'
cookbook 'ktc-utils', github: 'cloudware-cookbooks/ktc-utils', branch: 'services'
cookbook 'openstack-common', github: 'stackforge/cookbook-openstack-common'
cookbook 'openstack-ops-messaging', github: 'stackforge/cookbook-openstack-ops-messaging'
cookbook 'services', github: 'spheromak/services-cookbook'

group :integration do
  cookbook 'curl'
  cookbook 'ubuntu'
end
