#!/bin/sh
# run ./build.sh <package name>
docker run --rm -it -v $PWD/$1:/work -v $PWD/keys:/keys -v $PWD/keys/key.rsa.pub:/etc/apk/keys/key.rsa.pub -v $PWD/packages:/home/builder/packages abuild -v -r