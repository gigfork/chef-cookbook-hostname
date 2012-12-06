# defined in library

include_recipe "hostname::default"
include_recipe "dynect::default"
include_recipe "dynect"

register_host_with_dynect
