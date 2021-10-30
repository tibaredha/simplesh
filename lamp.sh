#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Check if running as root  
if [ "$(id -u)" != "0" ]; then  
	echo "This script must be run as root" 1>&2  
	exit 1  
fi


# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Install AMP
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert -y

echo -e "$Cyan \n Installing PHP & Requirements $Color_Off"
sudo apt-get install libapache2-mod-php5 php5 php5-common php5-curl php5-dev php5-gd php5-idn php-pear php5-imagick php5-mcrypt php5-mysql php5-ps php5-pspell php5-recode php5-xsl -y

# Ask value for mysql root password   
# read -p 'db_root_password [secretpasswd]: ' db_root_password  
# echo
# Install MySQL database server  
# export DEBIAN_FRONTEND="noninteractive"  
# debconf-set-selections <<< "mysql-server mysql-server/root_password password $db_root_password"  
# debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $db_root_password"  
# apt-get install mysql-server -y  


echo -e "$Cyan \n Installing MySQL $Color_Off"
sudo apt-get install mysql-server mysql-client libmysqlclient15.dev -y

echo -e "$Cyan \n Installing phpMyAdmin $Color_Off"
sudo apt-get install phpmyadmin -y

## Configure PhpMyAdmin  
## echo 'Include /etc/phpmyadmin/apache.conf' >> /etc/apache2/apache2.conf 

echo -e "$Cyan \n Verifying installs$Color_Off"
sudo apt-get install apache2 libapache2-mod-php5 php5 mysql-server php-pear php5-mysql mysql-client mysql-server php5-mysql php5-gd -y

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo php5enmod mcrypt

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart

# chmod +x lamp.sh

# nano ~/.bashrc
# alias setuplamp = "sh ~/lamp.sh"
# setuplamp