class Chef::Recipe
  # 
  # Generate and fqdn based on role and environment values. 
  # 
  # it allows the dynamic building of the node's fqdn depending on attributes
  # set in the node's environment and roles. 
  #
  # If a separate 'zone role' is create that sets the zone_code on a node,
  # it allow for the application of a core role (like 'webserver') into 
  # multiple zones and environments, each with a location specific fqdn.
  #

  def generate_fqdn
    host = node["host"] || node[:hostname]
    env_code = node["environment_code"] || "default"
    zone_code = node["zone_code"] || "undef"
    domain = node["base_domain"] || node[:domain]
    internal = node["internal_dns_code"] || "int"
    fqdn = "#{host}.#{env_code}.#{zone_code}.#{domain}"
    return fqdn
  end

  def generate_internal_fqdn
    host      = node["host"]              || node[:hostname]
    env_code  = node["environment_code"]  || "default"
    zone_code = node["zone_code"]         || "undef"
    domain    = node["base_domain"]       || node[:domain]
    internal  = node["internal_dns_code"] || "int"
    fqdn      = "#{host}.#{internal}.#{env_code}.#{zone_code}.#{domain}"
    return fqdn
  end
end

