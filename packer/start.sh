#!/bin/bash
cp /tmp/app_war/companyNews.war /var/lib/tomcat8/webapps
sudo service tomcat8 restart
sudo chkconfig tomcat8 on
