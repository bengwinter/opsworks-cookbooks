# Apache request monitoring with http://vuksan.com/linux/ganglia/index.html
case node["platform_family"]
when "rhel"
  package 'logcheck'
when "debian"
  package 'logtail'
end

cookbook_file '/tmp/ganglia-logtailer.tar.gz' do
  source 'ganglia-logtailer.tar.gz'
end

execute 'unpack ganglia-logtailer' do
  cwd '/tmp/'
  command 'tar -xvzf ganglia-logtailer.tar.gz'
end

execute 'install ganglia-logtailer' do
  command 'cd /tmp/ganglia-logtailer && make install'
end

execute 'cleanup install of ganglia-logtailer' do
  command 'rm -rf /tmp/ganglia-logtailer*'
end

# Apache worker monitoring with http://static.g.raphaelli.com/contrib/code/ganglia/
cookbook_file '/etc/ganglia/conf.d/apache.pyconf' do
  source 'apache.pyconf'
  mode "0644"
end

cookbook_file '/etc/ganglia/python_modules/apache.py' do
<<<<<<< HEAD
  path value_for_platform_family(
    "rhel" => "/usr/lib#{RUBY_PLATFORM[/64/]}/ganglia/python_modules/apache.py",
    "debian" => '/usr/lib/ganglia/python_modules/apache.py'
=======
  path value_for_platform(
    ['centos','redhat','fedora','amazon'] => {
      'default' => "/usr/#{RUBY_PLATFORM.match(/64/) ? 'lib64' : 'lib'}/ganglia/python_modules/apache.py"
    },
    ['debian','ubuntu'] => {'default' => '/usr/lib/ganglia/python_modules/apache.py'}
>>>>>>> fe3dbd0db74604fb8606e9a2f434b2393b3c9b90
  )
  source 'apache.py'
  mode "0644"
end
