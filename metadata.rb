name             'ktc-messaging'
maintainer       'KT Cloudware, Inc.'
maintainer_email 'wil.reichert@kt.com'
license          'All rights reserved'
description      'Installs/Configures ktc-messaging'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{
  ktc-utils
  openstack-common
  openstack-ops-messaging
}.each do |dep|
  depends dep
end
