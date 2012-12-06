class Chef::Recipe
  def register_host_with_dynect
    # register floating ip with dynect if it exists
    begin
      floating = node["openstack"]["latest"]["meta-data"]["public-ipv4"]
    rescue NoMethodError
      Chef::Log.info "Could not find floating ip for node!"
      floating = nil
    end
    if floating then
      Chef::Log.info "Creating A record for #{node[:fqdn]} to #{floating}"
      dynect_rr node.name do
        record_type "A"
        rdata({"address" => floating})
        fqdn node[:fqdn]
        customer node[:dynect][:customer]
        username node[:dynect][:username]
        password node[:dynect][:password]
        zone     node[:dynect][:zone]
        action :update
      end 
    end
    
    if not node[:int_fqdn].nil? then
      Chef::Log.info "Creating A record for #{node[:fqdn]} to #{node[:ipaddress]}"
      dynect_rr node.name do
        record_type "A"
        rdata({"address" => node[:ipaddress]})
        fqdn node[:int_fqdn]
        customer node[:dynect][:customer]
        username node[:dynect][:username]
        password node[:dynect][:password]
        zone     node[:dynect][:zone]
        action :update
      end 
    end
  end
end
