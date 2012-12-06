class Chef::Recipe

  def register_domain
    begin
      ip = node["openstack"]["latest"]["meta-data"]["public-ipv4"] 
    rescue NoMethodError
      ip = node[:ipaddress]
    end
    
    begin
      customer  = node[:dynect][:customer]
      username  = node[:dynect][:username]
      password  = node[:dynect][:password]
      zone      = node[:dynect][:zone]
    rescue NoMethodError
      Chef::Log.critical "No dynect credentials provided!"
    end

    domain = node[:domain]
    Chef::Log.info "Registering domain #{domain} with dynect..."

    dynect_rr node.name do
      record_type "A"
      rdata({"address" => ip})
      fqdn domain
      customer customer 
      username username 
      password password 
      zone     zone     
    end 
  end
end
