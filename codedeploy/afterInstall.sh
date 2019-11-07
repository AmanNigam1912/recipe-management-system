#!/bin/bash

cd /usr/share/tomcat/bin
./shutdown.sh
#sudo systemctl stop tomcat.service

# sudo rm -rf /opt/tomcat/webapps/docs /opt/tomcat/webapps/examples /opt/tomcat/webapps/host-manager /opt/tomcat/webapps/manager /opt/tomcat/webapps/ROOT
sudo rm -rf  /usr/share/tomcat/webapps/examples /usr/share/tomcat/webapps/host-manager /usr/share/tomcat/webapps/manager /usr/share/tomcat/webapps/ROOT
# /usr/share/tomcat/webapps/docs

# sudo chown tomcat:tomcat /opt/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/share/tomcat/webapps/Recipe_Management_System.war

# cleanup log files
# sudo rm -rf /opt/tomcat/logs/catalina*
# sudo rm -rf /opt/tomcat/logs/*.log
# sudo rm -rf /opt/tomcat/logs/*.txt

# cleanup log files
sudo rm -rf /usr/share/tomcat/logs/catalina*
sudo rm -rf /usr/share/tomcat/logs/*.log
sudo rm -rf /usr/share/tomcat/logs/*.log