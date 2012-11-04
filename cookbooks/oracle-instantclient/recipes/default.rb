#
# Cookbook Name:: oracle-instantclient
# Recipe:: default
#
# Copyright 2011, Joshua Buysse, (C) Regents of the University of Minnesota
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# installs from remote files

# dependencies
pkg_list = ["unzip", "libaio1"]
pkg_list.each do |pkg| 
  package pkg
end

if node[:kernel][:machine] == "x86_64" then
  arch_flag = ".x64"
else
  arch_flag = ""
end

basic_file_name = "instantclient-basic-linux#{arch_flag}-#{node[:oracle_instantclient][:client_version]}.zip"

directory node[:oracle_instantclient][:install_dir] do
  mode "0755"
  owner "root"
  group "root"
end

directory "#{node[:oracle_instantclient][:install_dir]}/dist" do
  mode "0755"
  owner "root"
  group "root"
end

remote_file "#{node[:oracle_instantclient][:install_dir]}/dist/#{basic_file_name}" do
  source "#{node[:oracle_instantclient][:download_base]}/#{basic_file_name}"
  action :create_if_missing
  notifies :run, "execute[unpack_instant_client]", :immediately
  notifies :run, "execute[run_ldconfig]", :delayed
end

template "/etc/ld.so.conf.d/oracle_instantclient.conf" do 
  source "oracle_instantclient.conf.erb"
  mode "0644"
  owner "root"
  notifies :run, "execute[run_ldconfig]", :delayed
end

template "/etc/profile.d/oracle_instantclient.csh" do 
  source "oracle_instantclient.csh.erb"
  mode "0644"
  owner "root"
end

template "/etc/profile.d/oracle_instantclient.sh" do 
  source "oracle_instantclient.sh.erb"
  mode "0644"
  owner "root"
end

execute "unpack_instant_client" do
  command "/usr/bin/unzip -o #{node[:oracle_instantclient][:install_dir]}/dist/#{basic_file_name} -d #{node[:oracle_instantclient][:install_dir]}"
  action :nothing
  notifies :run, "script[add_soname_symlink]", :immediately
end

script "add_soname_symlink" do 
  interpreter "bash"
  code <<-EOC
  cd #{node[:oracle_instantclient][:install_dir]}/#{node[:oracle_instantclient][:client_dir_name]}
  ln -sf libclntsh.so.11.1 libclntsh.so
  EOC
  action :nothing
end

execute "run_ldconfig" do 
  command "/sbin/ldconfig"
  action :nothing
end

