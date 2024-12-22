#!/bin/sh
# Get all the folders in this directory, excluding "keys", "packages" and all files
# Usage: ./csall.sh

for i in $(ls -d */); do
	if [ "$i" != "keys/" ] && [ "$i" != "packages/" ]; then
		echo "Checksumming $i"
		./checksum.sh $i
	fi
done