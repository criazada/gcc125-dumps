#!/usr/bin/env bash

dump=dump
archive=archive2
baseport=8000

archive() {
    url="$1"
    dst="$(realpath $2)"
    content="$(curl -Ls --max-time 10 "$1")"
    if [ -n "$content" ]; then
        httrack "$url" -%T -u0 -O "$dst" "-drive.google.com/*" "-docs.google.com/*"
    fi
}

cleanup() {
    folder="$1"
    if [ -d "$folder" ]; then
        pushd "$folder"
        mkdir -p tmp
        find -maxdepth 1 ! -name . ! -name tmp -exec mv \{\} tmp \;
        cp -r tmp/192*/. .
        rm -r tmp
        popd
    fi
}

mkdir -p $archive
for i in $(seq 1 255); do
    ip="192.168.1.$i"
    archive "http://$ip" "$archive/$ip"
    cleanup "$archive/$ip"
done
