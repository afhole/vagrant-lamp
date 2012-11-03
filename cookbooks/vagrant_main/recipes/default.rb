include_recipe "apt"
include_recipe "build-essential"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_vhost_alias"
include_recipe "mysql"
include_recipe "mysql::ruby"
include_recipe "mysql::server"
include_recipe "database"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "php::module_curl"
include_recipe "php::module_xmlrpc"
include_recipe "php::module_gd"
include_recipe "php::module_intl"
include_recipe "php::module_ldap"
include_recipe "oracle-instantclient"
include_recipe "oracle-instantclient::php"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "dynamic-vhosts" do
  template "dynamic-vhosts.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end

#grant root access to mysql guest from VM host
mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}
mysql_database_user 'root' do
  connection mysql_connection_info
  password node['mysql']['server_root_password']
  host "192.168.0.1"
  action :grant
end



# web_app "project" do
#   template "project.conf.erb"
#   notifies :reload, resources(:service => "apache2"), :delayed
# end
