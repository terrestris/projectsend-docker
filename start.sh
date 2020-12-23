#!/bin/bash
echo "Populating mounted upload-dir"

mkdir -p /data/projectsend \
         /config/projectsend

PREV_DIR=$(pwd)

cd /defaults/upload || exit
shopt -s globstar nullglob
shopt -s dotglob
	for i in *
	do
		if [ ! -e "/data/projectsend/${i}" ] ; then
		cp -R "${i}" "/data/projectsend/${i}"
		chown www-data:www-data "/data/projectsend/${i}"
		fi
	done

shopt -u globstar nullglob
shopt -u dotglob

cd "${PREV_DIR}" || exit

# create symlinks
[[ ! -L /var/www/html/upload ]] && \
	ln -sf /data/projectsend /var/www/html/upload
[[ -f /var/www/html/includes/sys.config.php ]] && \
	rm /var/www/html/includes/sys.config.php
[[ ! -L /var/www/html/includes/sys.config.php ]] && \
	ln -sf /config/projectsend/sys.config.php \
	/var/www/html/includes/sys.config.php

# permissions
chown www-data:www-data \
	/data \
	/data/projectsend

chown -R www-data:www-data \
	/config
	
  apache2-foreground
