#!/bin/sh
# run ./checksum.sh <package name>
docker run --rm -it -v $PWD/$1:/work -v $PWD/keys:/keys -v $PWD/packages:/home/builder/packages abuild checksum