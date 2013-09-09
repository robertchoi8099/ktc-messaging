# vim: ft=sh:

@test "rabbit registered with etcd" {
  wget http://localhost:4001/v1/keys/services/rabbitmq/members
}

@test "rabbit is running" {
  rabbitmqctl status | grep pid
}
