FROM nginx

RUN apt-get update && \
    apt-get install -y procps vim

COPY ./etc/nginx/nginx.conf /etc/nginx
COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d

RUN mkdir -p /data/lib/xpla-lcd-cache && \
    chown nginx:nginx /data/lib/xpla-lcd-cache
