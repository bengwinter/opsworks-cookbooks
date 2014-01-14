include_attribute "deploy"

default[:rails][:version] = "2.3.5"

ENV['API_KEY'] = node[:env][:api_key]