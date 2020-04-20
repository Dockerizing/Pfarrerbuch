# Pfarrebuch Docker Container

This container provides the Pfarrerbuch OntoWiki in a container.
It is forked from https://github.com/Dockerizing/OntoWiki.

## Usage instructions

This container just has the static OntoWiki files ready configured to be served by a php and nginx container.
Additionally it requires a virtuoso container as database backend.

This image is built to be used in the Pfarrebuch Docker Compose setup: https://github.com/Dockerizing/Pfarrebuch.compose
