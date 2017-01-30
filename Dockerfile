FROM farmcoolcow/rclone

MAINTAINER Jean-Michel Ruiz <mail@coolcow.org>

ENV ENTRYPOINT_USER=rclone
ENV ENTRYPOINT_GROUP=rclone
ENV ENTRYPOINT_HOME=/home
ENV CROND_CRONTAB=/crontab

RUN touch $CROND_CRONTAB

ENTRYPOINT ["/entrypoint_crond.sh"]
CMD ["-f"]
