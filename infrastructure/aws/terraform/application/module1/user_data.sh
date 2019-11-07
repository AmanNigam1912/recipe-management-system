#! /bin/sh
#sudo touch /opt/tomcat/bin/setenv.sh
#sudo chmod 777 /opt/tomcat/bin/setenv.sh
sudo touch /usr/share/tomcat/bin/setenv.sh
sudo chmod 777 /usr/share/tomcat/bin/setenv.sh
# sudo echo 'export JAVA_OPTS="-Daws.s3.bucketname='${s3_bucket_name}'"' > /opt/tomcat/bin/setenvvar.sh
# sudo echo 'JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.url=jdbc:mysql://'${aws_db_endpoint}'/'${aws_db_name}'"' >> /opt/tomcat/bin/setenvvar.sh
# sudo echo 'JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.username='${aws_db_username}'"' >> /opt/tomcat/bin/setenvvar.sh
# sudo echo 'JAVA_OPTS="$JAVA_OPTS -Dspring.datasource.password='${aws_db_password}'"' >> /opt/tomcat/bin/setenvvar.sh
# sudo echo 'JAVA_OPTS="$JAVA_spring.OPTS -Daws.region='${aws_region}'"' >> /home/aman/bin/setenvvar.sh
# sudo echo 'JAVA_OPTS="$JAVA_OPTS -Daws.profile='${aws_profile}'"' >> /home/aman/bin/setenvvar.sh
sudo echo "JAVA OPTS=\"\$JAVA_OPTS"\" >> /usr/share/tomcat/bin/setenv.sh
sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Durl=${aws_db_endpoint}"\" >> /usr/share/tomcat/bin/setenv.sh
sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dbucket=${s3_bucket_name}"\" >> /usr/share/tomcat/bin/setenv.sh
sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -DdbName=${aws_db_name}"\" >> /usr/share/tomcat/bin/setenv.sh
sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dusername=${aws_db_username}"\" >> /usr/share/tomcat/bin/setenv.sh
sudo echo "JAVA_OPTS=\"\$JAVA_OPTS -Dpassword=${aws_db_password}"\" >> /usr/share/tomcat/bin/setenv.sh