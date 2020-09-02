dfsioe_jar = "autogen-8.0-SNAPSHOT-jar-with-dependencies.jar"
dfsioe_jar_url = "https://repo.hops.works/dev/maism/HiBench/#{dfsioe_jar}"

bench_dir = "#{node['install']['dir']}/benchmarks"

directory bench_dir do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    action :create
end

remote_file "#{bench_dir}/#{dfsioe_jar}" do
    source dfsioe_jar_url
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