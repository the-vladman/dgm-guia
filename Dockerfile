# Imagen de NGINX
FROM nginx

# Copiar la carpeta de del compilado
COPY _site /usr/share/nginx/html/guia

# Personalizar configuracion de nginx
COPY default.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
