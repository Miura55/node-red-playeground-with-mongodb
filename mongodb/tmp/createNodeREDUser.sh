#!/bin/bash

if [ ! -n "$1" ]; then
	echo "Usage: $0 <database>"
	exit 1
fi

until mongo --quiet --host mongodb -u "root" -p "admin" --authenticationDatabase 'admin' --eval "db.serverStatus()" --quiet; do
	echo 2>&1 "MongoDB is unavailable - sleeping"
	sleep 1
done

# create database
mongo --quiet --host mongodb -u "root" -p "admin" --authenticationDatabase 'admin' <<EOT
use $1
db.createUser(
	{
		user: "nodered",
		pwd: "nodered",
		roles: [
			{
				role: "readWrite",
				db: "$1"
			}
		]
	}
) 
EOT
