FROM alpine:3.16

RUN apk add --no-cache \
      ca-certificates \
      supercronic \
      jq \
      restic \
      rclone \
      docker \
      git \
      coreutils \
      make

COPY entrypoint.sh /

RUN git clone https://github.com/kmmndr/restic.mk.git /tmp/restic.mk \
 && cd /tmp/restic.mk/ \
 && make install \
 && rm -rf /tmp/restic.mk

VOLUME "/etc/cron/"

ENTRYPOINT [ "/entrypoint.sh" ]
