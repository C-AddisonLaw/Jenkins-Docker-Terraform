#!/bin/sh
set -x
echo "Moving bootstrap files and script from /tmp to /opt"
mv /tmp/bootstrap /opt/
chmod +x /opt/bootstrap/bootstrap.sh

echo "Running Bootstrap"
sh /opt/bootstrap/bootstrap.sh > /var/log/bootstrap.log
