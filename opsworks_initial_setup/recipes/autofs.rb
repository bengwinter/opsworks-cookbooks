package "autofs"

service "autofs" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

<<<<<<< HEAD
template node[:opsworks_initial_setup][:autofs_map_file] do
  source "automount.opsworks.erb"
  mode "0444"
  owner "root"
  group "root"
end

ruby_block "Update autofs configuration" do
  block do
    handle_to_master = Chef::Util::FileEdit.new("/etc/auto.master")
    handle_to_master.insert_line_if_no_match(
      node[:opsworks_initial_setup][:autofs_map_file],
      "/- #{node[:opsworks_initial_setup][:autofs_map_file]} -t 3600"
    )
    handle_to_master.write_file
  end
  notifies :restart, "service[autofs]", :immediately
=======
template '/etc/auto.opsworks' do
  source 'automount.opsworks.erb'
  mode 0444
  owner 'root'
  group 'root'
  notifies :restart, resources(:service => 'autofs'), :immediately
end

bash "Add auto.opsworks to /etc/auto.master and restart autofs" do
  code <<-EOF
    echo "/- /etc/auto.opsworks" >> /etc/auto.master
  EOF
  notifies :restart, resources(:service => 'autofs'), :immediately
>>>>>>> fe3dbd0db74604fb8606e9a2f434b2393b3c9b90
  not_if { ::File.read('/etc/auto.master').include?('auto.opsworks') }
end
