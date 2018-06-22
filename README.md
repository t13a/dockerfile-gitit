Gitit
=====

Dockerfile for [Gitit](https://github.com/jgm/gitit).

## Usage

### Getting started

    $ docker run --rm \
    -p 5001:5001 \
    t13a/gitit

### Set custom configuration

    $ docker run --rm \
    ...
    -e TIMEZONE="Asia/Tokyo" \
    -v $(pwd)/gitit:/gitit \
    -v $(pwd)/pandoc:/pandoc \
    ...
    t13a/gitit

### Run in specific UID/GID

    docker run --rm \
    ...
    -e PUID=1001 \
    -e PGID=1002 \
    ...
    t13a/gitit
