ARG ALPINE_VERSION=3.11.3

FROM alpine:${ALPINE_VERSION}

ARG LFTP_VERSION=4.8.4-r2
RUN apk --no-cache add ca-certificates openssh lftp

# Labels: http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="toolhous-lftp" \
      org.label-schema.description="File transfer container, powered by LFTP" \
      org.label-schema.url="https://github.com/toolhouse/docker-lftp" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/toolhouse/docker-lftp" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV LOCAL_PATH /files
VOLUME ["$LOCAL_PATH"]

# The following variables should be set:
# ENV REMOTE_SERVER sftp://ftp.example.com
# ENV USERNAME      user
# ENV PASSWORD      pass
# ENV REMOTE_PATH   /remote/path

# The following variables have reasonable defaults that 
# can be overriden if necessary:
ENV NET_LIMIT_RATE                      0
ENV NET_LIMIT_MAX                       0
ENV NET_LIMIT_TOTAL_RATE                0
ENV NET_LIMIT_TOTAL_MAX                 0

ENV NET_TIMEOUT                        30
ENV NET_RECONNECT_INTERVAL_BASE        15
ENV NET_RECONNECT_INTERVAL_MULTIPLIER   2
ENV NET_MAX_RETRIES                     5
ENV NET_PERSIST_RETRIES                 5
ENV MIRROR_PARALLEL_DIRECTORIES      true
ENV MIRROR_PARALLEL_TRANSFER_COUNT      3
ENV MIRROR_SET_PERMISSIONS          false

ENV SFTP_AUTO_CONFIRM                true
ENV SFTP_MAX_PACKETS_IN_FLIGHT         16
ENV SFTP_PROTOCOL_VERSION               6
ENV SFTP_SERVER_PROGRAM              sftp

ADD ./_func    /_func
ADD ./help     /help
ADD ./upload   /upload
ADD ./download /download

CMD ["/help"]
