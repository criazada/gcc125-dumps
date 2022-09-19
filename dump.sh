#!/usr/bin/env bash

folder=dump

download() {
    content="$(curl -Ls --max-time 10 "$1")"
    if [ -n "$content" ]; then
        pushd "$2"
        echo "Downloading $1"
        wget --quiet --recursive --no-parent "$1"
        popd
    fi
}

mkdir -p "$folder"
for i in $(seq 1 255); do
  download "http://192.168.1.$i" "$folder" &
done

download "http://192.168.1.37/relatorios"
