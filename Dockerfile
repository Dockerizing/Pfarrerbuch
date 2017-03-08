FROM debian:latest

MAINTAINER Natanael Arndt <arndt@informatik.uni-leipzig.de>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update package index
RUN apt-get update

# install some basic packages
# install the nginx server with PHP
RUN apt-get install -y \
    git make curl \
    php5-cli php5-curl

RUN rm -rf /var/www/*
RUN mkdir -p /var/www/html/

RUN curl https://getcomposer.org/composer.phar -o composer.phar
RUN chmod +x composer.phar
RUN ./composer.phar create-project --keep-vcs aksw/ontowiki /var/www/html/ dev-develop
RUN cd /var/www/html/ && git submodule init && git submodule update

RUN cp /var/www/html/config.ini.dist /var/www/html/config.ini

# Add startscript and start
ADD start.sh /start.sh
ADD ow-docker.fig /ow-docker.fig

VOLUME /var/www/html/

CMD ["/bin/bash", "/start.sh"]
