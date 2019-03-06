#!/bin/bash
echo -n "Enter your domain name and press [ENTER]: "
read domain

sudo apt-get update
sudo apt-get install ssh -y
sudo apt-get install apache2 -y
sudo apt-get install mariadb-server mariadb-client
sudo apt install php libapache2-mod-php php-common php-sqlite3 php-curl php-intl php-mbstring php-xmlrpc php-mysql php-gd php-xml php-cli php-ldap php-apcu php-zip -y
sudo apt-get install unzip -y

DB_ROOT_PASS='root'

DB_Name='chamilo'
DB_User='chamilouser'
DB_Pass='password@1234Chamilo'

sudo mysql -u root --password=$DB_ROOT_PASS <<MYSQL_SCRIPT
CREATE DATABASE $DB_Name;
CREATE USER '$DB_User'@'localhost' IDENTIFIED BY '$DB_Pass'
GRANT ALL ON $DB_Name.* TO '$DB_User'@'localhost' IDENTIFIED BY '$DB_Pass' with GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

wget https://github.com/chamilo/chamilo-lms/releases/download/v1.11.6/chamilo-1.11.6-php7.zip
unzip chamilo-1.11.6-php7.zip
sudo mv chamilo-1.11.6 /var/www/html/chamilo
sudo chown -R www-data:www-data /var/www/html/chamilo
sudo chmod -R 755 /var/www/html/chamilo

echo "MySQL user created."
echo "Database Name	:	$DB_Name"
echo "Database Username	:	$DB_User"
echo "Database Password	:	$DB_Pass"

sudo touch /etc/apache2/sites-available/chamilo.conf
sudo echo "<VirtualHost *:80>
ServerAdmin admin@$domain.com
DocumentRoot /var/www/html/chamilo
ServerName $domain.com

<Directory /var/www/html/chamilo/>
Options FollowSymlinks
AllowOverride All
Require all granted
</Directory>

ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> chamilo.conf

sudo a2ensite chamilo.conf
sudo a2enmod rewrite
sudo systemctl restart apache2.service
echo "Chamilo Successfully Installed"
echo "Open your $domain or http://localhost/chamilo"
echo "Continue installation in your browser"
echo "Save this information"
echo "MySQL Root Password	: $DB_ROOT_PASS"
echo "Database Name		    : $DB_Name"
echo "Database Username		: $DB_User"
echo "Database Password		: $DB_Pass"
