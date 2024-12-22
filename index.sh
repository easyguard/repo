#!/bin/sh
# run ./index.sh <arch>
docker run --rm -it -v $PWD/keys:/etc/apk/keys -v $PWD:/work -v $PWD/keys:/keys -v $PWD/packages:/home/builder/packages --entrypoint sh abuild -c "apk index -o /home/builder/packages/$1/APKINDEX.tar.gz /home/builder/packages/$1/*.apk"
# docker run --rm -it -v $PWD:/work -v $PWD/keys:/keys -v $PWD/packages:/home/builder/packages --entrypoint ls abuild /home/builder/packages/$1/*.apk