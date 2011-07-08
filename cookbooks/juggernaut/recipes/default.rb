#
# Cookbook Name:: juggernaut
# Recipe:: default
#
# Install and start Juggernaut server
#
# IMPORTANT: This has to run AFTER node.js is isntalled

if ['app','app_master','solo'].include?(node[:instance_role])
#  version_tag     = "v0.4.7"
#  source_base_dir = "/data/nodejs"
#  source_dir      = "#{source_base_dir}/#{version_tag}"
  install_dir     = "/usr/local/bin"

  ey_cloud_report "juggernaut" do
    message "Setting up juggernaut server"
  end

  execute "npm install juggernaut" do
    command "npm install -g juggernaut"
    not_if { FileTest.exists?("#{install_dir}/juggernaut") }
  end

  execute "start juggernaut" do
    command "#{install_dir}/juggernaut"
#    not_if { FileTest.exists?("#{install_dir}/juggernaut") }
  end

end

