#!/usr/bin/env bash

dump=dump
archive=archive
baseport=8000

archive() {
    src="$1"
    dst="$(realpath $2)"
    port="$3"
    if [ -d "$src" ]; then
        pushd "$src"
        python -m http.server "$3" &
        pid=$!
        httrack "http://127.0.0.1:$port" -O "$dst" "-drive.google.com/*" "-docs.google.com/*"
        kill $pid
        popd
    fi
}

cleanup() {
    folder="$1"
    if [ -d "$folder" ]; then
        pushd "$folder"
        mkdir -p tmp
        find -maxdepth 1 ! -name . ! -name tmp -exec mv \{\} tmp \;
        cp -r tmp/127*/. .
        rm -r tmp
        popd
    fi
}

for i in $(seq 1 255); do
    ip="192.168.1.$i"
    archive "$dump/$ip" "$archive/$ip" $(($baseport + $i))
    cleanup "$archive/$ip"
done
