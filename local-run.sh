#!/bin/bash -ex

cd "$(dirname "$(readlink -f "${0}")")"
rm -rf ./dist ./build

mkdir build
pushd build
git clone -b emacs-30.1 --depth 1 https://github.com/emacs-mirror/emacs emacs-src
popd

docker build .  # next step has no log, so build first
IMAGE_ID=$(docker build -q .)

./build.sh "$IMAGE_ID" ./build/emacs-src BUILD_GUI=lucid BUILD_NATIVE_COMP=no
