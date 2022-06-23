#!/bin/bash
SUDO_UID=0     # Only users with $UID 0 have root privileges.
E_NOTSUDO=100  # Non-root exit error.
ARCH=$(uname -i)

if [ "$UID" -ne "$SUDO_UID" ]
then
  echo "Must be sudo user to run this script."
  exit $E_NOTSUDO
fi  

which aws &> /dev/null || {
	echo "Installing aws-cli"
    which curl &> /dev/null || apt install curl -y && echo "curl is installed"
    which unzip &> /dev/null || apt install unzip -y && echo "unzip is installed"

    curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH.zip" -o "awscliv2.zip"
    
    unzip $PWD/awscliv2.zip
    sudo $PWD/aws/install
} && {
 AWS_ACCESS_KEY_ID=$(aws --region=us-east-1 ssm get-parameter --name "wardahh-access-key" --with-decryption --output text --query Parameter.Value)
 echo ${AWS_ACCESS_KEY_ID}

 AWS_SECRET_ACCESS_KEY=$(aws --region=us-east-1 ssm get-parameter --name "wardahh-secret-key" --with-decryption --output text --query Parameter.Value)
 echo ${AWS_SECRET_ACCESS_KEY}
}
