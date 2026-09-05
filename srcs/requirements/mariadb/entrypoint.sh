#!/bin/bash
set -e
DB_PASS=$(cat /run/secrets/db_password)
ROOT_PASS=$(cat /run/secrets/db_root_password)

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    mysqld_safe --datadir=/var/lib/mysql &
    sleep 5
    mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mariadb -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
    mariadb -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASS}';"
    mariadb -e "FLUSH PRIVILEGES;"
    mysqladmin shutdown -p"${ROOT_PASS}"
fi

exec mysqld_safe --datadir=/var/lib/mysql

