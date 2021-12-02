#!/bin/sh

mkdir -p /var/lib/docker/volumes

if [ $# -eq 0 ]; then
	echo "*** Starting supercronic ***"

	if [ ! -f /etc/cron/crontab ]; then
		echo '/!\ Crontab file is missing, using default config'
		cat > /etc/cron/crontab <<-EOF
			# s m h  dom mon dow   command
			#   m h  dom mon dow   command
			0 */4 * * * restic.mk backup-docker-volumes backup-virtual-volumes
			30 6 * * * restic forget --keep-last 10 --keep-daily 7 --keep-monthly 6 --prune
		EOF
	fi

	echo "Crontab:"
	cat /etc/cron/crontab
	supercronic /etc/cron/crontab
else
	exec "$@"
fi
