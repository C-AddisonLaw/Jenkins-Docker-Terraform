#!/bin/sh
set -x
echo "Enabling and Changing Docker permissions"
systemctl enable docker
systemctl start docker
usermod -a -G dockerroot centos

echo "Modifying /etc/docker/daemon.json for dockerroot for centos user"
echo > /etc/docker/daemon.json
tee -a /etc/docker/daemon.json > /dev/null <<EOT
{
    "live-restore": true,
    "group": "dockerroot"
}
EOT

systemctl restart docker

echo "Downloading Files from git"
cd /opt/bootstrap/
wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/yogeshvk1209/jenkins_setup/master/packer/bootstrap/Dockerfile --output-document=Dockerfile
wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/yogeshvk1209/jenkins_setup/master/packer/bootstrap/plugins.txt --output-document=plugins.txt
wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/yogeshvk1209/jenkins_setup/master/packer/bootstrap/jenkins.yaml --output-document=jenkins.yaml
wget --no-check-certificate --content-disposition https://raw.githubusercontent.com/yogeshvk1209/jenkins_setup/master/packer/bootstrap/security.groovy --output-document=security.groovy

echo "Building Docker Image"
docker build -t jcasc-demo /opt/bootstrap/

sleep 60
echo "Running Jenkins Docker container"
docker run --name jcasc-demo -d -p 8080:8080 -v jenkins_home-jcasc:/var/jenkins_home jcasc-demo
