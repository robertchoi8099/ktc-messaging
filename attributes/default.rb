include_attribute "rabbitmq::default"

# process monitoring
default["openstack"]["mq"]["mq_processes"] = [
  { "name" => "rabbitmq-server", "shortname" => "rabbitmq-server" },
  { "name" => "beam.smp", "shortname" => "beam.smp" }
]

default['rabbitmq']['tcp_listen_keepalive'] = true
# make every queue as mirrored queue
default['rabbitmq']['policies']['ha-all']['pattern'] = "^(?!amq\\.).*"
