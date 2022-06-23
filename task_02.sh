#!/bin/bash
# This script verify that the NGINX service is active or inactive.

ROOT_UID=0    
E_NOTROOT=100  
red='\033[0;31m'
green='\033[0;32m'

    if [ "$UID" -ne "$ROOT_UID" ]
    then
        echo "Must be root to run this script. $(white")
        exit $E_NOTROOT
    fi
      status=$(systemctl is-active nginx)

      if [ $status  ne "active" ]
      then
        echo -e  "NGINX is Dead. Do you want to run NGINX [y/n] $(red")
        read start
        if [ $start=~ ^([yY][eE][sS]|[yY])$ ]
        then
            systemctl start nginx
            systemctl enable nginx
        fi 
      else
        echo "NGINX is Running"
      fi
