# Gitit

Dockerfile for [Gitit](https://github.com/jgm/gitit).

## Getting started

```sh
$ docker run --rm -p 5001:5001 t13a/gitit
```

## Configuration

### Mount prepared volumes

```sh
$ docker run \
...
-v $(pwd)/gitit.conf:/gitit.conf \
-v $(pwd)/gitit:/gitit \
...
t13a/gitit
```

To generate default configuration, execute `docker run --rm t13a/gitit gitit --print-default-config > gitit.conf`. The user data directory will be populated automatically.

### Set timezone

```sh
$ docker run \
...
-e TIMEZONE=Asia/Tokyo \
...
t13a/gitit
```

### Set process UID/GID

```sh
$ docker run \
...
-e GITIT_UID=1234 \
-e GITIT_GID=5678 \
...
t13a/gitit
```

## Advanced usage

### Generate GraphViz/PlantUML diagram (**Experimental**)

For details, please see [my Gitit plugins](http://github.com/t13a/gitit-plugins).

    $ docker run --rm \
    ...
    t13a/gitit:experimental # instead of t13a/gitit

By default, diagram generation is delegated to [public PlantUML server](http://www.plantuml.com/plantuml/). To use custom server, set URL to `PLANTUML_SERVER_URL` environment variable.

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
