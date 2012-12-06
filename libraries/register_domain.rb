class Chef::Recipe

  def register_domain
    begin
      ip = node["openstack"]["latest"]["meta-data"]["public-ipv4"] || node[:ipaddress]
    rescue NoMethodError
      Chef::Log.info "Could not find floating ip for node!"
      ip = node[:ipaddress]
    end
    
    Chef::Log.info "Creating A record for #{node[:fqdn]} to #{ip}"
    dynect_rr node.name do
      record_type "A"
      rdata({"address" => ip})
      fqdn node[:fqdn]
      customer node[:dynect][:customer]
      username node[:dynect][:username]
      password node[:dynect][:password]
      zone     node[:dynect][:zone]
      action :update
    end 
  end
end
