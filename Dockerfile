# Copyright 2020 Toolhouse, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG ALPINE_VERSION=3.11.3

FROM alpine:${ALPINE_VERSION}

ARG LFTP_VERSION=4.9.1-r0
RUN apk --no-cache add ca-certificates openssh
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main add lftp=${LFTP_VERSION}

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
ENV CREATE_REMOTE_DIR_CMD           false

ENV INSECURE_SKIP_SSL_VERIFICATION  false

ENV SFTP_AUTO_CONFIRM                true
ENV SFTP_MAX_PACKETS_IN_FLIGHT         16
ENV SFTP_PROTOCOL_VERSION               6
ENV SFTP_SERVER_PROGRAM              sftp

ADD ./_func    /_func
ADD ./help     /help
ADD ./upload   /upload
ADD ./download /download

CMD ["/help"]
