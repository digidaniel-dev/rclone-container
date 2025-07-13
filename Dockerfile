FROM alpine:latest AS build

RUN apk update && apk add \
  curl

RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip rclone-current-linux-amd64.zip && \
  cd rclone-*-linux-amd64 && \
  cp rclone /usr/bin && \
  chown root:root /usr/bin/rclone && \
  chmod 755 /usr/bin/rclone

COPY sync_rclone_cron /etc/cron.d/sync_rclone_cron
RUN crontab /etc/cron.d/sync_rclone_cron

RUN chmod 0644 /etc/cron.d/sync_rclone_cron

COPY sync_rclone.sh /usr/local/bin/sync_rclone.sh
RUN chmod +x /usr/local/bin/sync_rclone.sh

CMD ["crond", "&&", "tail", "-f", "/var/log/cron.log"]
