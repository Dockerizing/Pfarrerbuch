# OntoWiki Docker Container

This container provided [OntoWiki](http://ontowiki.net) ([@github](https://github.com/AKSW/OntoWiki)) in a container.

## Usage instructions

You can run the container with the following command.
To run OntoWiki you also need a running virtuoso container, which you have to link with the `--link` argument as shown below.
In order to access the OntoWiki with your browser you should also bind the internal HTTP port `80` to some host port.
The `-d` option runs the container in detached mode (in the background).

    docker run -d -p <http port on the host>:80 --link <virtuoso container name>:store <other argument see below> ontowiki:latest

If you want to keep the ontowiki logs in a host directory you can do it with the following argument:

    -v <host directory for ontowiki logs>:/var/www/logs

