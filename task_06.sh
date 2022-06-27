#!/bin/bash

status=$(systemctl is-active nginx)
echo $status
sed -i "s/NGINX - STATUS/$status/g" /var/www/html/index.html


version=$(nginx -v 2>&1 | awk -F' ' '{print $3}' | cut -d / -f 2)
echo $version
sed -i "s/NGINX - VERSION/$version/g" /var/www/html/index.html


AWS_CLI_VERSION=$(aws --version 2>&1 | cut -d " " -f1 | cut -d "/" -f2)
echo $AWS_CLI_VERSION

sed -i "s/VERSION - AWS/$AWS_CLI_VERSION/g" /var/www/html/index.html

aws ec2 describe-instances >> ec2.txt

ec2_count=$(grep -o -i "running" ec2.txt | wc -l)
 echo $ec2_count

aws ec2 describe-security-groups >> sg.txt

sg_count=$(grep -o -i "GroupName" sg.txt | wc -l)
echo $sg_count

sed -i "s/EC2 - COUNT/ $ec2_count/g" /var/www/html/index.html

sed -i "s/SG - COUNT/ $sg_count/g" /var/www/html/index.html

