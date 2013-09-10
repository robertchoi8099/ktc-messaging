name             'ktc-messaging'
maintainer       'KT Cloudware, Inc.'
maintainer_email 'wil.reichert@kt.com'
license          'All rights reserved'
description      'Installs/Configures ktc-messaging'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "ktc-utils", "~> 0.3.1"
depends "openstack-common", "~> 0.4.3"
depends "openstack-ops-messaging", "~> 7.0.0"
depends "services", "~> 1.0.6"
depends "users", "~> 1.1.4"
