#!/bin/bash

#-f Fail silently (no output at all) on server errors.
#s--silent Silent or quiet mode. Don't show progress meter or error messages.
#-S, --show-error and when used with -s , it will show an error
#-L, --location If the server reports that the requested page has moved to a different location
#A System/software update is typically a release containing enhancements to the current version. 
#An upgrade is a whole new version of software that represents a significant change or major improvement.
#DEB - A deb package (.deb file) is a software package in a specific format designed for Debian-based distributions recognized by the .deb extension. \
#Deb packages allow installing local software on an Ubuntu system.





sudo apt update -y

sudo apt upgrade -y 

sudo apt install openjdk-17-jre -y

sudo mkdir -p /etc/apt/keyrings

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list

sudo apt-get update -y 
sudo apt-get install jenkins -y
