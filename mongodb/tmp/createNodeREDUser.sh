#!/bin/bash

mongo --quiet --host mongodb -u "root" -p "admin" --authenticationDatabase 'admin' <<'EOT'
use shop
db.createUser(
	{
		user: "nodered",
		pwd: "nodered",
		roles: [
			{
				role: "readWrite",
				db: "shop"
			}
		]
	}
) 
EOT
