FROM nginx
MAINTAINER Giovanni Mendoza "mendozagioo@gmail.com"

ADD _site /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/
