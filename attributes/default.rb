# enable/disable monitoring
#
default[:ktc][:messaging][:monitor] = node[:ktc][:monitor] || true
