FROM nginx

RUN apt-get update && \
    apt-get install -y procps vim

COPY ./etc/nginx/nginx.conf /etc/nginx
COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d

RUN mkdir -p /data/lib/nginx/archive-cache && \
    chown nginx:nginx /data/lib/nginx/archive-cache && \
    mkdir -p /data/lib/nginx/moments-cache && \
    chown nginx:nginx /data/lib/nginx/moments-cache
