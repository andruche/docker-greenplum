#!/bin/bash

set -e

/etc/init.d/ssh start
sleep 1
su - gpadmin bash -c 'gpstart -a'

trap "kill %1; su - gpadmin bash -c 'gpstop -a -M fast' && END=1" INT TERM

tail -f `ls /data/{master,coordinator}/gpsne-1/{pg_log,log}/gpdb-* | tail -n1` &

#trap
while [ "$END" == '' ]; do
  sleep 1
done
