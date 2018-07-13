#!/bin/bash

set -eu

if [ $# -lt 1 ]
then
  echo "Usage: $0 repository [listen_port=2230]" 1>&2
  exit 1
fi

REPO=$1
SRCPORT=${2:-2230}

for id in $(docker images $REPO -q)
  do echo image_id=$id
  docker save $id | nc --send-only -l 0.0.0.0 $SRCPORT
done
