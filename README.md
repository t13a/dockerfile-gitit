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

    $ docker run --rm \
    ...
    -e PUID=1001 \
    -e PGID=1002 \
    ...
    t13a/gitit

### Generate GraphViz/PlantUML diagram (**Experimental**)

For details, please see [my Gitit plugins](http://github.com/t13a/gitit-plugins).

    $ docker run --rm \
    ...
    t13a/gitit:experimental # instead of t13a/gitit

By default, diagram generation is delegated to [public PlantUML server](http://www.plantuml.com/plantuml/).  To use custom server, set URL to `PLANTUML_SERVER_URL` environment variable.

    $ docker run --rm \
    ...
    -e PLANTUML_SERVER_URL=https://your-plantuml-server \
    ...
    t13a/gitit:experimental

This feature depends on `httplib2` module that uses own CA certificates where located in `/usr/local/lib/python2.7/dist-packages/httplib2/cacerts.txt`.  If you want to use system CA bundle, please specify path to `PLANTUML_CA_BUNDLE` environment variable.

    $ docker run --rm \
    ...
    -e PLANTUML_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
    ...
    t13a/gitit:experimental
