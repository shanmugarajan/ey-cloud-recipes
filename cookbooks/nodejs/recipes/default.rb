#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Build and install node.js on Engine Yard AppCloud
#
# (taken from https://gist.github.com/970051)
#

if ['app','app_master','solo'].include?(node[:instance_role])
  version_tag     = "v0.4.7"
  source_base_dir = "/data/nodejs"
  npm_base_dir    = "/data/npm"
  source_dir      = "#{source_base_dir}/#{version_tag}"
  install_dir     = "/usr/local/bin"

  ey_cloud_report "node.js" do
    message "Setting up node.js"
  end

  ey_cloud_report "nodejs" do
    message "configuring nodejs #{version_tag}"
  end

  directory "#{source_base_dir}" do
    owner 'deploy'
    group 'deploy'
    mode 0755
    recursive true
  end

  directory "#{npm_base_dir}" do
    owner 'deploy'
    group 'deploy'
    mode 0755
    recursive true
  end

  # download nodejs source and checkout specific version
  execute "fetch nodejs from GitHub" do
    command "git clone https://github.com/joyent/node.git #{source_dir}"
    not_if { FileTest.exists?(source_dir) }
  end
  execute "use tagged version of nodejs" do
    command "cd #{source_dir} && git checkout #{version_tag}"
    not_if { FileTest.exists?(source_dir) }
  end

  # compile nodejs
  execute "configure nodejs" do
    command "cd #{source_dir} && ./configure"
    not_if { FileTest.exists?("#{source_dir}/node") }
  end
  execute "build nodejs" do
    command "cd #{source_dir} && make && make install"
    not_if { FileTest.exists?("#{source_dir}/node") }
  end
  execute "symlink nodejs" do
    command "ln -s #{source_dir}/node #{install_dir}"
    not_if { FileTest.exists?("#{install_dir}/node") }
  end

#  ey_cloud_report "nodejs" do
#    message "Installing NPM"
#  end
#  execute "install NPM" do
#    command "cd #{source_base_dir} && curl http://npmjs.org/install.sh | sh"
#    not_if { FileTest.exists?("#{install_dir}/npm") }
#  end

  ey_cloud_report "nodejs" do
    message "Installing NPM"
  end
  # download npm
  execute "fetch npm from GitHub" do
    command "git clone http://github.com/isaacs/npm.git #{npm_base_dir}/latest"
    not_if { FileTest.exists?("#{npm_base_dir}/latest") }
  end
  execute "build npm" do
    command "cd #{npm_base_dir}/latest && make install"
    not_if { FileTest.exists?("#{install_dir}/npm") }
  end


end

