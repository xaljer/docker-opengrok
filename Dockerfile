FROM tomcat:9-alpine
LABEL maintainer="xaljer@outlook.com"

ARG OPENGROK_VERSION=1.1-rc16
ENV OPENGROK_DIRECTORY /usr/opengrok
ENV OPENGROK_INSTANCE_BASE /var/opengrok

RUN apk add --no-cache git subversion mercurial
RUN apk add --no-cache --virtual .ctag-build-deps gcc g++ make automake autoconf \
  && cd / \
  && git clone --depth 1 https://github.com/universal-ctags/ctags.git \
  && cd /ctags/   \
  && ./autogen.sh \
  && ./configure  \
  && make \
  && make install  \
  && rm -rf /ctags \
  && apk del .ctag-build-deps
RUN apk add --no-cache --virtual .opengrok-install-deps ca-certificates openssl \
  && cd / \
  && wget -O - https://github.com/OpenGrok/OpenGrok/releases/download/$OPENGROK_VERSION/opengrok-$OPENGROK_VERSION.tar.gz | tar zxvf - \
  && mv opengrok-* $OPENGROK_DIRECTORY \
  && apk del .opengrok-install-deps \
  && mkdir -p $OPENGROK_INSTANCE_BASE \
  && OPENGROK_TOMCAT_BASE=$CATALINA_HOME $OPENGROK_DIRECTORY/bin/OpenGrok deploy

