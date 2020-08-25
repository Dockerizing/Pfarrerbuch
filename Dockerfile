FROM debian:jessie

LABEL maintainer="Natanael Arndt <arndt@informatik.uni-leipzig.de>"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# OntoWiki Site Extension configuration
ENV OW_SITE_MODEL "https://pfarrerbuch.aksw.org/"

# update package index
# and install some basic required packages
RUN apt-get update && \
    apt-get install -y git make curl php5-cli php5-curl && \
    rm -rf /var/lib/apt/lists/*

# Prepare installations directory
RUN rm -rf /var/www/* && mkdir -p /var/www/html/

# clone ontowiki and get its dependencies
RUN git clone https://github.com/AKSW/pfarrerbuch.de.git /var/www/html/
RUN cd /var/www/html/ && make deploy && make custom

WORKDIR /var/www/html/

RUN cp config.ini.dist config.ini

# Add startscript and start
ADD start.sh /start.sh
ADD ow-docker.fig /ow-docker.fig

VOLUME /var/www/html/

CMD ["/bin/bash", "/start.sh"]
