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
#  install_dir     = "/usr/local/bin"

  ey_cloud_report "juggernaut" do
    message "Setting juggernaut server"
  end

#  ey_cloud_report "nodejs" do
#    message "configuring nodejs #{version_tag}"
#  end

#  directory "#{source_base_dir}" do
#    owner 'root'
#    group 'root'
#    mode 0755
#    recursive true
#  end

  #
  execute "fetch nodejs from GitHub" do
    command "git clone https://github.com/joyent/node.git #{source_dir}"
    not_if { FileTest.exists?(source_dir) }
  end
end

