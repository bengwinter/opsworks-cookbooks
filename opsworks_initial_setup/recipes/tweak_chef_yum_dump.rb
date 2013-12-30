<<<<<<< HEAD
# on micro instances the hard-coded lock_timeout of 10 seconds can be too low
bash 'set lock timeout in Chef\'s yum-dump.py' do
  user 'root'
  code <<-EOC
    sed -i '/^lock_timeout/I s/=\s.*$/= #{node[:opsworks_initial_setup][:yum_dump_lock_timeout]}/' #{node[:opsworks_initial_setup][:yum_dump_file]}
  EOC
  only_if { node[:platform] == 'amazon' }
=======
if node[:platform] == 'amazon'
  # the hard-coded lock_timeout of 10 seconds can be too low
  bash 'set lock timeout in Chef\'s yum-dump.py' do
    user 'root'
    code <<-EOC
      sed -i 's/lock_timeout\s=\s.*$/lock_timeout = #{node[:opsworks_initial_setup][:yum_dump_lock_timeout]}/' #{node[:opsworks_agent][:current_dir]}/vendor/bundle/ruby/1.8/gems/chef-0.9.15.5/lib/chef/provider/package/yum-dump.py
    EOC
  end
>>>>>>> fe3dbd0db74604fb8606e9a2f434b2393b3c9b90
end
