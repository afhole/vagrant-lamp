Vagrant::Config.run do |config|

  guest_ip              = "192.168.0.10"
  mysql_root_password   = "password"

  config.vm.box         = "precise64"
  config.vm.box_url     = "https://files.vagrantup.com/precise64.box"
  config.vm.share_folder  "v-root", "/vagrant", ".", :nfs => true
  config.vm.network       :hostonly, guest_ip
  config.vm.customize    ["modifyvm", :id, "--memory", 768]
  
  config.vm.provision :chef_solo do |chef|

    chef.cookbooks_path = "cookbooks"
    chef.add_recipe       "vagrant_main"
    chef.json = 
    {
      :mysql => 
        { :server_root_password => mysql_root_password, :bind_address => guest_ip }
    }
  end
  
end