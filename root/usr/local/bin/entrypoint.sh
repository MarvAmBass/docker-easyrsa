#!/bin/bash

source_vars () {
  if [ -f '/ca/vars' ]; then
    echo ">> source /ca/vars"
    source /ca/vars
  fi
}

echo ">> enter /ca/ as workdir"
cd /ca

source_vars

if [ $(ls -la /ca/ | wc -l) -le 3 ]; then
 echo ">> initializing /ca/ with default rsa installation"
 cp -a /usr/share/easy-rsa/* /ca/
 vi /ca/vars
 source_vars
 ./clean-all
 sed -i 's/default_crl_days.*/default_crl_days= 3650/g' openssl-*
else
 echo ">> /ca/ already initialized... continuing"
fi

echo ">> enter /ca/ as workdir"
cd /ca

# exec CMD
echo ">> exec docker CMD"
echo "$@"
exec "$@"
