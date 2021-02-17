# docker-digdag-server

## How to build this image

### Build latest image

```shell
$ docker build -t digdag-server:latest .
```

### Build target version image

```shell
$ docker build -t digdag-server:tag --build-arg VERSION=0.9.42 .
```

Releases(https://docs.digdag.io/releases.html)

## How to use this image

### Start a `digdag server` instance

Starting a Digdag instance is simple:
```shell
$ docker run -d --name some-digdag -e OPTIONS="--memory" digdag-server:tag
```

### Main Options

```
--disable-executor-loop      disable workflow executor loop
--disable-scheduler          disable scheduler
--disable-local-agent        disable local task execution
--enable-swagger             enable swagger api. Do not use in production because CORS
                             is also enabled on from any domains with all HTTP methods
```

If you need only WebUI/API

```shell
$ docker run -d --name some-digdag -e OPTIONS="--disable-local-agent --disable-executor-loop --disable-scheduler" digdag-server:tag
```

If you need Agent/Workflow/Scheduler

```shell
$ docker run -d --name some-digdag digdag-server:tag
```

### Startup Script

`CMD` runs as a startup script

```shell
$ docker run -d --name some-digdag \
    -e OPTIONS="... --config /app/server.properties" \
    digdag-server:tag \
    'apk add --no-cache aws-cli; aws s3 cp s3://bucket/path/to/server.properties /app'
```
