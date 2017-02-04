FROM farmcoolcow/rclone

MAINTAINER Jean-Michel Ruiz (coolcow) <mail@coolcow.org>

# Build-time metadata as defined at http://label-schema.org

ARG BUILD_DATE
ARG VCS_REF
ARG IMAGE_NAME
ARG VERSION

LABEL maintainer="Jean-Michel Ruiz (coolcow) <mail@coolcow.org>" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.description="Docker farmcoolcow/rclone image using crond as default entrypoint." \
      org.label-schema.name="$IMAGE_NAME" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://hub.docker.com/r/$IMAGE_NAME/" \
      org.label-schema.license="GPL-3.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/farmcoolcow/docker_rclone-cron" \
      org.label-schema.vendor="coolcow.org" \
      org.label-schema.version="$VERSION"

# Evironment variables

ENV ENTRYPOINT_USER=rclone \
    ENTRYPOINT_GROUP=rclone \
    ENTRYPOINT_HOME=/home \
    CROND_CRONTAB=/crontab


# creating empty crontab
RUN touch $CROND_CRONTAB


ENTRYPOINT ["/entrypoint_crond.sh"]

CMD ["-f"]
