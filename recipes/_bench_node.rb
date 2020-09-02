package "nmon" do
    action :install
end

kagent_keys node['hops']['hdfs']['user-home'] do
    cb_user node['hops']['hdfs']['user']
    cb_group node['hops']['group']
    cb_name "hops"
    cb_recipe "_bench"
    action :get_publickey
end