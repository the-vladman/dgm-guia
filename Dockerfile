FROM ubuntu:14.04
MAINTAINER Giovanni Mendoza "mendozagioo@gmail.com"

RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

#Actaulizacion de paquetes e instalacion de dependencias
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget curl git git-core build-essential \
    libmysqlclient-dev libpq-dev \
    zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
    libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev nginx

# Personalizar configuracion de nginx
COPY default.conf /etc/nginx/conf.d

# Carpeta para contenido de aplicacion
RUN mkdir -p /usr/share/guia
RUN mkdir -p /usr/share/nginx/html/guia

# Obtener ruby version 2.1.2
WORKDIR /tmp
RUN wget -O ruby-2.1.2.tar.gz http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar -xzf ruby-2.1.2.tar.gz

# Instalacion de ruby
WORKDIR ./ruby-2.1.2/
RUN ./configure && make && make install

# cache bundler
COPY . /usr/share/guia
WORKDIR /usr/share/guia

# Intalacion de gemas
RUN gem install bundler
RUN bundle install
RUN jekyll build --destination /usr/share/nginx/html/guia

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]