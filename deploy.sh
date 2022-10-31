#!/bin/sh

# help
usage() {
	echo "Usage: sh deploy.sh [mysql|redis|nginx|java|stop]"
	exit 1
}

# start mysql
mysql(){
	docker-compose up -d docker-mysql
}

# start redis
redis(){
	docker-compose up -d docker-redis
}

# start nginx
nginx(){
	if [ ! -f "./nginx/cachepurge/source" ]; then
  		mkdir ./nginx/cachepurge
		echo "https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz" > ./nginx/cachepurge/source 
	fi
	docker-compose --compatibility up --build -d docker-nginx
}

# start java jar
java(){
	docker-compose --compatibility up -d docker-candypay
}

# stop all
stop(){
	docker-compose stop
}

case "$1" in
"mysql")
	mysql
;;
"redis")
	redis
;;
"nginx")
	nginx
;;
"java")
	java
;;
"stop")
	stop
;;
*)
	usage
;;
esac
