include_attribute "sysctl"

default['sysctl']['params']['net']['ipv4']['tcp_keepalive_time'] = 5
default['sysctl']['params']['net']['ipv4']['tcp_keepalive_probes'] = 5
default['sysctl']['params']['net']['ipv4']['tcp_keepalive_intvl'] = 1
