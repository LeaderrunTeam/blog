FROM lhrdc/nginx:latest
COPY ./.vitepress/dist /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=15s --timeout=5s --retries=20 --start-period=30s CMD curl --fail --silent 127.0.0.1/actuator/health | grep UP || exit 1

ENTRYPOINT ["nginx", "-g", "daemon off;"]
