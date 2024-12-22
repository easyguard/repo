#!/bin/sh
# Get all the folders in this directory, excluding "keys", "packages" and all files
# Usage: ./csall.sh

set -e # Exit on error

for i in $(ls -d */); do
	if [ "$i" != "keys/" ] && [ "$i" != "packages/" ]; then
		echo "Building $i"
		./build.sh $i
	fi
done