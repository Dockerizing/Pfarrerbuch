#!/bin/sh

CONFFILE=/var/www/html/config.ini
SITE_CONFFILE=/var/www/html/site/config.ini

# set Virtuoso password in ontowikis config.ini
sed -i "s/\(store.virtuoso.password\s*\)= \"dba\"$/\1= \"${DBA_PASSWORD}\"/" ${CONFFILE}


# configure OntoWiki site extensions
sed -i s,model\ \=\ \"https://pfarrerbuch.aksw.org/\"$,model\ \=\ \"$OW_SITE_MODEL\",g ${SITE_CONFFILE}

if [ -z ${OW_SITE_INDEX+x} ]
then
    # $OW_SITE_INDEX not set
    sed -i s,index\ \=\ \"https://pfarrerbuch.aksw.org/About\"$,index\ \=\ \"${OW_SITE_MODEL}About\",g ${SITE_CONFFILE}
else
    # $OW_SITE_INDEX set
    sed -i s,index\ \=\ \"https://pfarrerbuch.aksw.org/About\"$,index\ \=\ \"$OW_SITE_INDEX\",g ${SITE_CONFFILE}
fi

if [ -z ${OW_SITE_ERROR+x} ]
then
    # $OW_SITE_ERROR not set
    sed -i s,error\ \=\ \"https://pfarrerbuch.aksw.org/NotFound\"$,error\ \=\ \"${OW_SITE_MODEL}NotFound\",g ${SITE_CONFFILE}
else
    # $OW_SITE_ERROR set
    sed -i s,error\ \=\ \"https://pfarrerbuch.aksw.org/NotFound\"$,error\ \=\ \"$OW_SITE_ERROR\",g ${SITE_CONFFILE}
fi

cat ${SITE_CONFFILE}


echo "OntoWiki is ready to set sail!"
cat /ow-docker.fig
echo ""
echo "following log:"

OWLOG_DIR="/var/www/html/logs/"
mkdir -p $OWLOG_DIR
chmod a+w $OWLOG_DIR

tail -f $OWLOG
