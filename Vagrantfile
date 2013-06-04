Vagrant.configure("2") do |config|

  guest_ip              = "192.168.0.10"
  mysql_root_password   = "password"

  config.vm.box         = "precise64"
  config.vm.box_url     = "https://files.vagrantup.com/precise64.box"
  config.vm.synced_folder  ".", "/vagrant", :nfs => true
  config.vm.network       :private_network, ip: guest_ip

  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
  
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = "cookbooks"
    chef.add_recipe       "vagrant_main"
    chef.json = 
    {
      :mysql => 
        {
          :server_root_password => mysql_root_password,
          :server_repl_password => mysql_root_password,
          :server_debian_password => mysql_root_password, 
          :bind_address => guest_ip
        },
        :build_essential =>
        {
          :compiletime => true
        }
    }
  end
  
end