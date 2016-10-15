#!/bin/bash

HOSTNAME=$(hostname)
sed -i "s/#id:/id: $HOSTNAME/g" /etc/salt/minion
systemctl restart salt-minion
