#!/bin/bash

# set permissions
sudo chmod -R 777 ./
# Set the password for Node-RED
npm install bcryptjs
YOUR_NODERED_PASSWORD=$(openssl rand -base64 12 | fold -w 10 | head -1)
UI_NODERED_PASSWORD_CRYPT=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" ${YOUR_NODERED_PASSWORD})

# Write password to .env file
if [ -e ".env" ]; then
    rm .env
fi

echo "NODE_RED_PASSWORD='${UI_NODERED_PASSWORD_CRYPT}'" >>.env

docker-compose up -d
sleep 10s
docker-compose run --rm mongodb /tmp/createNodeREDUser.sh shop

echo "Your Node-RED password:${YOUR_NODERED_PASSWORD}"
