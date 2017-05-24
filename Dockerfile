FROM nginx
MAINTAINER Giovanni Mendoza "mendozagioo@gmail.com"

COPY default.conf /etc/nginx/confg.d

RUN mkdir -p /usr/share/nginx/html/guia

#Instalacion ruby
RUN apt-get update
RUN apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev wget

WORKDIR /tmp

RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz

RUN tar -xvzf ruby-2.1.2.tar.gz

WORKDIR ./ruby-2.1.2/
RUN ./configure --prefix=/usr/local
RUN make
RUN make install

RUN gem install bundler

# cache bundler
COPY Gemfile /usr/share/nginx/html/guia
RUN bundle install

COPY . /usr/share/nginx/html/guia

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]