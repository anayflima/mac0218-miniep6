FROM caddy:2.5.1
COPY Caddyfile /etc/caddy/Caddyfile
COPY pages /usr/src/pages