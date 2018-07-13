#!/bin/bash

set -eu

if [ $# -lt 1 ]
then
  echo "Usage: $0 sender_ip [sender_port=2230]" 1>&2
  exit 1
fi

SRCIP=$1
SRCPORT=${2:-2230}

while [ 1 ]
do
  echo '/****************/'
  nc --recv-only $SRCIP $SRCPORT | docker load || break
  sleep 1
done
