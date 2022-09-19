#!/usr/bin/env bash

download() {
    content="$(curl -Ls --max-time 10 "$1")"
    if [ -n "$content" ]; then
        echo "Downloading $1"
        wget --quiet --recursive --no-parent "$1"
    fi
}

for i in $(seq 1 255); do
  download "http://192.168.1.$i" &
done

download "http://192.168.1.37/relatorios"

