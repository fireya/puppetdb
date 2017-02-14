#!/bin/bash

if [ ! -d "/etc/puppetlabs/puppetdb/ssl" ]; then
  while ! nc -z ${PUPPET_MASTER_NAME} ${PUPPET_MASTER_PORT}; do
    sleep 1
  done
  set -e
  /opt/puppetlabs/bin/puppet config set certname ${HOSTNAME}
  /opt/puppetlabs/bin/puppet agent --verbose --onetime --no-daemonize --waitforcert 120
  /opt/puppetlabs/server/bin/puppetdb ssl-setup -f
  /bin/chmod 0644 /etc/puppetlabs/puppetdb/conf.d/jetty.ini 
fi

exec /opt/puppetlabs/server/bin/puppetdb "$@"