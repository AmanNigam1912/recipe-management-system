#!/bin//bash

#sudo systemctl stop tomcat.service
cd /usr/share/tomcat/bin
./shutdown.sh
# sudo rm -rf /opt/tomcat/webapps/demo-0.0.1-SNAPSHOT.war
sudo rm -rf usr/share/tomcat/webapps/Recipe_Management_System.war