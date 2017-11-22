# docker-opengrok

Docker image for recent opengrok based on tomcat-alpine.
Version control tools (git, svn, hg) are equipped.

## Usage

### run

```sh
$ docker run -d --name opengrok \
-p [public port]:8080 \
-v [path/to/source]:/src \
-v [path/to/data]:/var/opengrok \
xaljer/docker-opengrok
```

### reindex

```sh
$ docker exec -it opengrok /usr/opengrok/bin/OpenGrok index /src
```

### view
<http://localhost:[public port]/source/xref>

## docker-compose example

```sh
version: '2'

service:
  opengrok:
    image: 'xaljer/docker-opengrok'
    restart: always
    ports:
      - '8080:8080'
    volumes:
      - '/srv/docker/opengrok/src:/src'
      - '/srv/docker/opengrok/data:/var/opengrok'
```
