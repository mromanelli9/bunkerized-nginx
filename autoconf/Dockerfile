FROM nginx:stable-alpine AS builder

FROM alpine

COPY --from=builder /etc/nginx/ /opt/confs/nginx

RUN apk add py3-pip apache2-utils bash certbot curl logrotate openssl && \
    pip3 install docker requests && \
    mkdir /opt/entrypoint && \
    mkdir -p /opt/confs/site && \
    mkdir -p /opt/confs/global && \
    mkdir /opt/scripts && \
    addgroup -g 101 nginx && \
    adduser -h /var/cache/nginx -g nginx -s /sbin/nologin -G nginx -D -H -u 101 nginx && \
    mkdir /var/log/letsencrypt && \
    chown root:nginx /var/log/letsencrypt && \
    chmod 770 /var/log/letsencrypt && \
    mkdir /var/lib/letsencrypt && \
    chown root:nginx /var/lib/letsencrypt && \
    chmod 770 /var/lib/letsencrypt && \
    mkdir /cache && \
    chown root:nginx /cache && \
    chmod 770 /cache && \
    touch /var/log/jobs.log && \
    chown root:nginx /var/log/jobs.log && \
    chmod 770 /var/log/jobs.log && \
    chown -R root:nginx /opt/confs/nginx && \
    chmod -R 770 /opt/confs/nginx

COPY autoconf/misc/logrotate.conf /etc/logrotate.conf
COPY scripts/* /opt/scripts/
COPY confs/site/ /opt/confs/site
COPY confs/global/ /opt/confs/global
COPY entrypoint/* /opt/entrypoint/
COPY autoconf/* /opt/entrypoint/
RUN chmod +x /opt/entrypoint/*.py /opt/entrypoint/*.sh /opt/scripts/*.sh

ENTRYPOINT ["/opt/entrypoint/entrypoint.sh"]
