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
