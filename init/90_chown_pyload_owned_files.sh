#!/bin/bash

if [ ! -f "/opt/pyload/pyload-config/setup.lock" ]
then
        mkdir -p /opt/pyload/pyload-config
        chmod 755 /opt/pyload/pyload-config
        mv /tmp/pyload-config/* /opt/pyload/pyload-config/
        find /opt/pyload ! \( -user abc -a -group abc \) -print0 | xargs -0 chown abc:abc
        touch /opt/pyload/pyload-config/setup.lock
fi

if [ -f "/opt/pyload/pyload-config/pyload.pid" ]
then
        rm /opt/pyload/pyload-config/pyload.pid
fi
