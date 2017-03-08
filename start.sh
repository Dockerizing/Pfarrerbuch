#!/bin/sh

CONFFILE=/var/www/html/config.ini

echo password: ${VIRTUOSO_ENV_DBA_PASSWORD}

head -n 40 ${CONFFILE} | tail

# set Virtuoso password in ontowikis config.ini
sed -i "s/\(store.virtuoso.password\s*\)= \"dba\"$/\1= \"${VIRTUOSO_ENV_DBA_PASSWORD}\"/" ${CONFFILE}

head -n 40 ${CONFFILE} | tail

echo "OntoWiki is ready to set sail!"
cat /ow-docker.fig
echo ""
echo "following log:"

OWLOG_DIR="/var/www/html/logs/"
OWLOG=$OWLOG_DIR"ontowiki.log"
EFLOG=$OWLOG_DIR"erfurt.log"
mkdir -p $OWLOG_DIR
ls -la $OWLOG_DIR

chmod a+w $OWLOG_DIR

touch $OWLOG
touch $EFLOG
chmod a+w $OWLOG
chmod a+w $EFLOG

tail -f $OWLOG
