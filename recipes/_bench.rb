
bench_dir = "#{node['install']['dir']}/benchmarks"

directory bench_dir do
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    action :create
end

test_jar = "hadoop-mapreduce-client-jobclient-3.2.0.0-EE-SNAPSHOT-tests.jar" 
cookbook_file "#{bench_dir}/#{test_jar}" do
    source test_jar
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
      :dfsio_jar => "#{bench_dir}/#{test_jar}"
    })
end

template "#{bench_dir}/dfsioe.sh" do
    source "bench/dfsioe.sh.erb"
    owner node['hops']['hdfs']['user']
    group node['hops']['group']
    mode 0750
    variables({
      :dfsio_jar => "#{bench_dir}/#{test_jar}"
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