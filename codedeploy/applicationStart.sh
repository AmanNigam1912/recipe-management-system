#!/bin//bash

# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
#     -a fetch-config \
#     -m ec2 \
#     -c file:/opt

# sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl 
#     -a fetch-config \
#     -m ec2 \
#     -c file:/opt/aws/amazon-cloudwatch-agent/cloudwatch-config.json \
#     -s

cd /usr/share/tomcat/bin
./startup.sh

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/cloudwatch-config.json -s
sudo systemctl start amazon-cloudwatch-agent
#sudo systemctl start tomcat.service
#sudo yum install -y awslogs
#sudo service awslogs start
#sudo systemctl start awslogsd