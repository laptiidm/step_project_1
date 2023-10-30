#!/bin/bash

# 
MYSQL_ROOT_PASSWORD="temp"
# 
echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
# 
sudo apt update
# 
sudo apt install -y mysql-server
# 
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE shop_db;"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON shop_db.* TO 'root'@'localhost';"
#
MYSQL_ADMIN_USER="shop"
MYSQL_ADMIN_PASSWORD="shop"
#
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_ADMIN_USER'@'localhost' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON shop_db.* TO '$MYSQL_ADMIN_USER'@'localhost'; FLUSH PRIVILEGES;"
#
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER 'mysql_exporter'@'localhost' IDENTIFIED BY 'exporter' WITH MAX_USER_CONNECTIONS 3;"
sudo mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'mysql_exporter'@'localhost'; FLUSH PRIVILEGES;"




