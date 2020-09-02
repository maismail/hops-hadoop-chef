package "nmon" do
    action :install
end

kagent_keys node['hops']['hdfs']['user-home'] do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    cb_name "hops"
    cb_recipe "_bench"
    action :get_publickey
end