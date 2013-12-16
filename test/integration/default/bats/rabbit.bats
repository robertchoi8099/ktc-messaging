# vim: ft=sh:

@test "rabbit registered with etcd" {
   curl -L http://127.0.0.1:4001/v1/keys/services/rabbitmq/members
}

@test "rabbit is running" {
  /usr/sbin/rabbitmqctl status | grep pid
}

@test "sysctl file created" {
  [[ -f /etc/sysctl.d/99-chef-attributes.conf ]]
}

