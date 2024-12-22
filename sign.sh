#!/bin/sh
# run ./sign.sh <arch>
docker run --rm -it -v $PWD:/work -v $PWD/keys:/keys -v $PWD/packages:/home/builder/packages --entrypoint abuild-sign abuild /home/builder/packages/$1/APKINDEX.tar.gz