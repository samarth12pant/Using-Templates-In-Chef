package 'httpd' do
    action :install
    case node[:platform_family]  # will help us identify the OS of client
    when 'rhel'  #if OS is RHEL then install httpd package otherwise if OS is Debian install apache2 package
        package_name 'httpd'
    when 'debian'
        package_name 'apache2'
    end        
end

template '/var/www/html/index.html' do  # will create index.html file using the index.html.erb template 
    source 'index.html.erb'
    mode '0755'
    owner 'root'
    group 'root'
end

service 'httpd' do
    action [:start, :enable]
    case node[:platform_family]  # will help us identify the OS of client
    when 'rhel'
        service_name 'httpd'
    when 'debian'
        service_name 'apache2'
    end
end
