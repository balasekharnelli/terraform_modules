#!/bin/bash
yum update
yum instll wget -y
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${jdk_url}
yum install -y jdk-8u141-linux-x64.rpm
yum install -y ${package} tomcat8-docs-webapp tomcat8-admin-webapps
sed -i 's/port="8080"/port="80"/' /etc/tomcat8/server.xml
service tomcat8 restart
