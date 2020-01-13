#!/bin/bash

cd ~
echo "Hello"
# Update packages
apt update
apt dist-upgrade -y

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start an nginx reverse proxy that handles SSL with Let's Encrypt
git clone https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion.git
cd docker-compose-letsencrypt-nginx-proxy-companion
cp .env.sample .env
./start.sh
cd ..

git clone https://github.com/viktorfa/strapi-app.git strapi
cd strapi

apt install mongodb-clients -y

MONGO_CONTAINER="mongo_container"

docker run -v $PWD/db:/data/db -d -p 27017:27017 --name $MONGO_CONTAINER mongo:3
mongo localhost:27017/admin mongo-init.js | tee mongo-passwords.txt
docker stop $MONGO_CONTAINER
docker rm $MONGO_CONTAINER

reboot
