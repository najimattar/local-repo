FROM nginx:alpine

RUN apk update && apk upgrade

COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/

EXPOSE 80
