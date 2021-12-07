#!/bin/sh
set -eu

stage=$1

cat <<EOF
COMPOSE_PROJECT_NAME=archiver
EOF

# The following variables are required
# RESTIC_REPOSITORY=
# RESTIC_PASSWORD=
# AWS_ACCESS_KEY_ID=
# AWS_SECRET_ACCESS_KEY=
# AWS_DEFAULT_REGION=

case "$stage" in
	*)
		;;
esac
