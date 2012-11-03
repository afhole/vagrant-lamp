#
# Cookbook Name:: oracle-instantclient
# Recipe:: sqlplus
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
# requires the default recipe

include_recipe "oracle-instantclient::default"

if node[:kernel][:machine] == "x86_64" then
  arch_flag = ".x64"
else
  arch_flag = ""
end

basic_file_name = "instantclient-jdbc-linux#{arch_flag}-#{node[:oracle_instantclient][:client_version]}.zip"

remote_file "#{node[:oracle_instantclient][:install_dir]}/dist/#{basic_file_name}" do
  source "#{node[:oracle_instantclient][:download_base]}/#{basic_file_name}"
  action :create_if_missing
  notifies :run, "execute[unpack_instant_client_jdbc]", :immediately
end

execute "unpack_instant_client_jdbc" do
  command "/usr/bin/unzip #{node[:oracle_instantclient][:install_dir]}/dist/#{basic_file_name} -d #{node[:oracle_instantclient][:install_dir]}"
  action :nothing
end
