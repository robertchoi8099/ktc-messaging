name             'ktc-messaging'
maintainer       'KT Cloudware, Inc.'
maintainer_email 'wil.reichert@kt.com'
license          'All rights reserved'
description      'Installs/Configures ktc-messaging'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.13'

depends "ktc-openstack-ha"
depends "ktc-monitor"
depends "ktc-utils"
depends "openstack-common", "~> 0.4.3"
depends "openstack-ops-messaging", "~> 7.0.0"
depends "rabbitmq"
depends "services"
depends "users"
