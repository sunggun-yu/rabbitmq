#
# Cookbook Name:: rabbitmq
# Recipe:: cluster
#
# Author: Sunggun Yu <sunggun.dev@gmail.com>
# Copyright (C) 2015 Sunggun Yu
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

include_recipe 'rabbitmq::default'

# Join in cluster : master node will be skipped.
if node[:rabbitmq][:clustering][:node_type] == 'slave'
  rabbitmq_cluster node[:rabbitmq][:clustering][:master_node_name] do
    action :join
  end
end

# Change the cluster node type : master node will be skipped. (for now)
rabbitmq_cluster node[:rabbitmq][:clustering][:master_node_name] do
  cluster_node_type node[:rabbitmq][:clustering][:cluster_node_type]
  action :change_cluster_node_type
end
