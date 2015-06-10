#!/bin/sh

CONFFILE=/var/www/config.ini

# set Virtuoso password in ontowikis config.ini
sed -i "s/\(store.virtuoso.password\s*\)= \"dba\"$/\1= \"${STORE_ENV_PWDDBA}\"/" ${CONFFILE}

# start the php5-fpm service
echo "starting php …"
service php5-fpm start

# start the nginx service
echo "starting nginx …"
service nginx start

echo "OntoWiki is ready to set sail!"
cat /ow-docker.fig
echo ""
echo "following log:"

OWLOG="/var/www/logs/ontowiki.log"
touch $OWLOG
chmod a+w $OWLOG
tail -f $OWLOG
