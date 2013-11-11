# process monitoring
default["openstack"]["mq"]["mq_processes"] = [
  { "name" => "rabbitmq-server", "shortname" => "rabbitmq-server" },
  { "name" => "beam.smp", "shortname" => "beam.smp" }
]
