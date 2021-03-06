#
# Cookbook Name:: statsd
# Recipe:: default
#
# Copyright 2013 Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.
#

include_recipe "nodejs"
include_recipe "runit"

package "git" do
  action :install
end

execute "git_clone" do
  user "root"
  group "root"
  command "git clone git://github.com/etsy/statsd.git /opt/statsd"
  creates "/opt/statsd"
end

template "/opt/statsd/config.js" do
  source "statsd-config.js.erb"
  mode 0644
  owner "root"
  group "root"
end

runit_service "statsd" do
  action [ :enable, :start ]
  service_name "statsd"
  default_logger true
end

