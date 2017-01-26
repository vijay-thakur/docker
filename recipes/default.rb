#
# Cookbook Name:: docker
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

isdocker = true

if File.exist?('/opt/mezzanine/Dockerfile')
  isdocker = false
end

template "/opt/mezzanine/Dockerfile" do
  source "Dockerfile.erb"
  mode "0755"
end

bash 'docker build' do
  cwd node['docker']['dockerfile_path']
 code <<-EOH
    set -e
    docker build -t mezzanine .
    docker run -d -t -p 80:8000 -i mezzanine /bin/bash
EOH
  only_if { isdocker == true }
end
