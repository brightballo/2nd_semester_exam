#!/bin/bash

# Update Cache & Upgrade
apt -y update && sudo apt -y upgrade

#Install GnuPG
apt install -y gnupg2

# Add PostgreSQL 
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Download PostgreSQL 
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update APT 
apt -y update

# Install PostgreSQL
apt -y install postgresql-15

# Create database
sudo -i -u postgres psql -c "CREATE DATABASE ballo WITH ENCODING 'UTF8' TEMPLATE template0"

# Create User
sudo -i -u postgres psql -c "CREATE USER ballo WITH ENCRYPTED PASSWORD 'ballo0000'"

# Grant  privilege 
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE ballo to ballo"

# Configure user login method in pg_hba.conf
echo -e 'local\tall\t\tballo\t\t\t\t\tmd5' >>/etc/postgresql/15/main/pg_hba.conf

systemctl restart postgresql
