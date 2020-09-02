package "pssh" do
    action :install
end

package "tmux" do
    action :install
end

dfsioe_jar = "hadoop-mapreduce-client-jobclient-3.2.0.0-EE-SNAPSHOT-tests.jar"

bench_dir = "#{node['install']['dir']}/benchmarks"

directory bench_dir do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    action :create
end

cookbook_file "#{bench_dir}/#{dfsioe_jar}" do
    source dfsioe_jar
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode "755"
end


template "#{bench_dir}/dfsio.sh" do
    source "bench/dfsio.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
    variables({
      :dfsio_jar => "#{bench_dir}/#{dfsioe_jar}"
    })
end

template "#{bench_dir}/dfsioe.sh" do
    source "bench/dfsioe.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
    variables({
      :dfsio_jar => "#{bench_dir}/#{dfsioe_jar}"
    })
end

template "#{bench_dir}/run_dfsioe.sh" do
    source "bench/run_dfsioe.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/dfsops.sh" do
    source "bench/dfsops.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/run_dfsops.sh" do
    source "bench/run_dfsops.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/teragen.sh" do
    source "bench/teragen.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/terasort.sh" do
    source "bench/terasort.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/teravalidate.sh" do
    source "bench/teravalidate.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/run_terabench.sh" do
    source "bench/run_terabench.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

bench_nodes = node['hops']['_bench_node']['private_ips'].join("\n")
bench_nodes += "\n"

file "#{bench_dir}/bench_nodes" do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode '644'
    content bench_nodes.to_s
    action :create
end

master_nodes = node['hops']['nn']['private_ips'].join("\n")
master_nodes += "\n"

file "#{bench_dir}/master_nodes" do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode '644'
    content master_nodes.to_s
    action :create
end

kagent_keys node['hops']['hdfs']['user-home'] do
    cb_user node['hops']['hdfs']['user']
    cb_group node['hops']['group']
    action :generate
end

kagent_keys node['hops']['hdfs']['user-home'] do
    cb_user node['hops']['hdfs']['user']
    cb_group node['hops']['group']
    cb_name "hops"
    cb_recipe "_bench"
    action :return_publickey
end

template "#{bench_dir}/run_nmon.sh" do
    source "bench/run_nmon.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end

template "#{bench_dir}/stop_and_collect_nmon.sh" do
    source "bench/stop_and_collect_nmon.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
end