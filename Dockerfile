FROM ubuntu:14.04

MAINTAINER Natanael Arndt <arndt@informatik.uni-leipzig.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update package index
RUN apt-get update

# install some basic packages
# install the nginx server with PHP
RUN apt-get install -y \
    git make curl \
    nginx-light \
    php5 php5-fpm php5-common php5-cli \
    php5-odbc php5-curl \
    unixodbc

# Add virtuoso odbc dependency for OntoWiki to be able to connect to virtuoso
ADD libvirtodbc0_7.2_amd64.deb /
RUN dpkg -i libvirtodbc0_7.2_amd64.deb

RUN rm -rf /var/www/*
RUN curl https://getcomposer.org/composer.phar -o composer.phar
RUN chmod +x composer.phar
RUN ./composer.phar create-project --keep-vcs aksw/ontowiki /var/www/ dev-feature/php-composer
RUN cd /var/www/ && git submodule init && git submodule update

RUN cp /var/www/config.ini.dist /var/www/config.ini

# configure the ontowiki site for nginx
ADD ontowiki-nginx.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/ontowiki-nginx.conf /etc/nginx/sites-enabled/

# configure odbc for virtuoso
ADD odbc.ini /etc/

# Add startscript and start
ADD start.sh /start.sh
ADD ow-docker.fig /ow-docker.fig

VOLUME /var/www/logs

CMD ["/bin/bash", "/start.sh"]

# expose the HTTP port to the outer world
EXPOSE 80
