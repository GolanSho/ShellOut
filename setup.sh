#!/usr/bin/env bash

CentOS_INSTALL(){

# Install needed packages and libs

sudo yum -y install libxslt-devel libxml2-devel python-pip python
sudo yum -y install mariadb-server mysql-connector-python.noarch mariadb-devel
sudo yum -y install git python-lxml.x86_64 python-devel
sudo yum -y groupinstall "Development tools"
wget https://bootstrap.pypa.io/get-pip.py && sudo python ./get-pip.py

# Upgrade lxml

sudo pip install -U lxml

# Start mysql server

sudo chkconfig mariadb on
sudo service mariadb start
sudo mysql_secure_installation

# CONPOT installation
git clone https://github.com/mushorg/conpot.git
cd conpot
sudo python setup.py install

# Open ports in firewalld : 80 , 102, 161 and 502

firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=102/tcp
firewall-cmd --permanent --add-port=161/tcp
firewall-cmd --permanent --add-port=502/tcp
firewall-cmd --reload
}

Debian_INSTALL(){

# Install dependencies:

sudo apt-get install git libsmi2ldbl smistrip libxslt1-dev python-dev libevent-dev

# The package snmp-mibs-downloader:

sudo wget $package_url
sudo dpkg -i $package_name
sudo deb http://ftp.nl.debian.org/debian squeeze main non-free

sudo apt-get install snmp-mibs-downloader

# Install conpot

cd /opt
sudo git clone https://github.com/mushorg/modbus-tk.git
cd modbus-tk
sudo python setup.py install
cd ..
sudo git clone https://github.com/mushorg/conpot.git
cd conpot
sudo python setup.py install
}

Ubuntu_INSTALL(){

# add multiverse to the source:

sudo echo "deb http://dk.archive.ubuntu.com/ubuntu precise main multiverse" >> /etc/apt/sources.list

# Install dependencies:

sudo apt-get install libmysqlclient-dev libsmi2ldbl snmp-mibs-downloader python-dev libevent-dev \
libxslt1-dev libxml2-dev python-pip python-mysqldb pkg-config libvirt-dev

# Install conpot

cd /opt
sudo git clone git@github.com:mushorg/conpot.git
cd conpot
sudo python setup.py install
}
Check_Installer(){

sudo yum -y update &> /dev/null

if [ $? = 0 ]; then
    echo "Starting CentOS Installation" &&
    CentOS_INSTALL
fi

sudo apt-get -y update &> /dev/null

if [ $? = 0 ]; then
    read -p "Debian or Ubuntu? (D/U) " os 
    if [ $os = D ]; then
	echo "Starting Debian Installation" &&
	Debian_INSTALL
    elif [ $os = U ]; then
	echo "Starting Ubuntu Installation" &&
	Ubuntu_INSTALL
    fi
else
    echo "OS Not Supported"
fi
}

# MAIN #

Check_Installer

# To Start the Conpot honeypot:

# conpot --template ( template )

