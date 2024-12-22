# EasyGuard Repository

This repository provides the Alpine Linux repository for EasyGuard (and its package sources).

## Development

First of all you need to generate a key at key.rsa and key.rsa.pub. Copy this key to packages/key.rsa.pub (DO NOT COPY THE PRIVATE KEY TOO).
Then you need docker installed on your machine and you need to build the abuild image in this repo: `docker build -t abuild .`
Note: This image sets http://ftp.halifax.rwth-aachen.de as the mirror for the Alpine Linux packages. If you are not in Germany, you might want to change this.

Now you can use the utility scripts in this repository.

- `./checksum.sh <package>` will generate the checksums for the specified package.
- (`./csall.sh` will generate the checksums for all packages.)
- `./build.sh <package>` will build the specified package.
- (`./buildall.sh` will build all packages.)
- `./index.sh <arch>` will generate the index for the specified architecture.
- `./sign.sh <arch>` will sign the repository for the specified architecture.

A normal workflow would be to run `./checksum.sh <package>`, `./build.sh <package>`, `./index.sh <arch>` and `./sign.sh <arch>` in this order.
