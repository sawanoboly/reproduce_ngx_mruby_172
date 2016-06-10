FROM alpine:3.3
MAINTAINER sawanoboriyu@higanworks.com

RUN apk add --update openssl-dev git curl geoip-dev file wget bash tar \
  && apk add --virtual build-deps build-base ruby-rake bison perl pcre-dev \
  && apk add --virtual reproduce php-fpm vim
#   && curl -L https://github.com/cubicdaiya/nginx-build/releases/download/v$NGINX_BUILD/nginx-build-linux-amd64-$NGINX_BUILD.tar.gz -o nginx-build.tar.gz \
#   && tar xvzf nginx-build.tar.gz \
#   && ./nginx-build -verbose -v $NGINX_VER -d work -pcre -zlib -m /config/modules3rd.ini -c /config/configure.sh --clear \
#   && cd work/nginx/$NGINX_VER/nginx-$NGINX_VER \
#   && make install \
#   && apk del build-deps \
#   && mv ../ngx_mruby/mruby/bin/* /usr/local/bin/ \
#   && rm -rf /var/cache/apk/* /usr/local/src/*

# RUN cd /usr/local/share/GeoIP \
#  && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gunzip GeoLiteCity.dat.gz \
#  && wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz && gunzip GeoIP.dat.gz


ADD ngx_mruby /ngx_mruby
WORKDIR /ngx_mruby

ENV BUILD_DYNAMIC_MODULE true
RUN sh build.sh && make install
RUN install -o nobody -g nobody -d /var/log/nginx

# Configurations to reproduce
ADD config/nginx.conf /ngx_mruby/ngx_mruby/build_dynamic/nginx/conf/nginx.conf
ADD html/index.php /ngx_mruby/ngx_mruby/build_dynamic/nginx/html/index.php

ADD entry.sh /entry.sh
EXPOSE 8080
CMD ["/entry.sh"]
