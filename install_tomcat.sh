#!/bin/bash
#This script will install java and tomcat on a ubuntu machine
sudo apt update -y
sudo apt install openjdk-11-jre-headless -y

tomcat_version=$(sudo apt-cache search tomcat | grep admin | awk -F "-" '{print $1}')
echo "Printing version $tomcat_version"

case $tomcat_version in

  tomcat9)
    echo -n "Installing Tomcat version 9"
    sudo apt install tomcat9 tomcat9-admin -y
    ;;

  tomcat8)
    echo -n "Installing Tomcat version 8"
    sudo apt install tomcat8 tomcat8-admin -y
    ;;

  tomcat7)
    echo -n "Installing Tomcat version 7"
    sudo apt install tomcat7 tomcat7-admin -y
    ;;

  *)
    echo -n "Unknow Tomcat Version. Not installing.."
    ;;
esac
echo "Creating a backup of tomcat users file"
sudo mv /etc/tomcat9/tomcat-users.xml /etc/tomcat9/tomcat-users-original.xml
sudo cp -rp tomcat-users.xml /etc/tomcat9/tomcat-users.xml
sudo systemctl restart tomcat9
wget "https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war"
cp -rp sample.war /var/lib/tomcat9/webapps/
