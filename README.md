Gitit
=====

Dockerfile for [Gitit](https://github.com/jgm/gitit).

Following packages are included:

-  `t13a/gitit:base`
   -  Pandoc
-  `t13a/gitit:extra`
   -  Graphviz
   -  PlantUML
   -  TeX Live

## Usage

### Getting started

    docker run --rm \
    -p 5001:5001 \
    t13a/gitit:base

### Use custom configuration

    docker run --rm \
    ...
    -e TIMEZONE="Asia/Tokyo" \
    -v $(pwd)/gitit:/gitit \
    -v $(pwd)/pandoc:/pandoc \
    ...
    t13a/gitit:base

### Run in specific UID/GID

    docker run --rm \
    ...
    -e PUID=1001 \
    -e PGID=1002 \
    ...
    t13a/gitit:base
