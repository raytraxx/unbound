#!/bin/bash

shopt -s nullglob

echo "ksjdf"

for file in /unbound-extra-conf.d/*.conf; do
    echo "include-toplevel: $file" >> /opt/unbound.conf
done

unbound -c /opt/unbound.conf
