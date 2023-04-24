# docker-greenplum

Difference from datagrip version:
* Fast start (~ 2 sec) due to pre-initialization of the cluster on build stage
* Support Apple M1 processor
* Correct stop
* Printing greenplum logs to container logs

GPORCA optimizer temporarily disabled (some compilation problems)

## Build images
```
$ docker buildx build --platform linux/arm64/v8 -f 6/DockerFile -t andruche/greenplum:6.24.1-slim-arm64 .
$ docker push andruche/greenplum:6.24.1-slim-arm64
$ docker buildx build --platform linux/amd64 -f 6/DockerFile -t andruche/greenplum:6.24.1-slim-amd64 .
$ docker push andruche/greenplum:6.24.1-slim-amd64

$ docker buildx build --platform linux/arm64/v8 -f 7/DockerFile -t andruche/greenplum:7.0.0-b2-slim-arm64 .
$ docker push andruche/greenplum:7.0.0-b2-slim-arm64
$ docker buildx build --platform linux/amd64 -f 7/DockerFile -t andruche/greenplum:7.0.0-b2-slim-amd64 .
$ docker push andruche/greenplum:7.0.0-b2-slim-amd64
```

## Build manifests
```
$ docker manifest create andruche/greenplum:6.24.1 --amend andruche/greenplum:6.24.1-slim-arm64 --amend andruche/greenplum:6.24.1-slim-amd64
$ docker manifest push andruche/greenplum:6.24.1

$ docker manifest create andruche/greenplum:7.0.0-b2 --amend andruche/greenplum:7.0.0-b2-slim-arm64 --amend andruche/greenplum:7.0.0-b2-slim-amd64
$ docker manifest push andruche/greenplum:7.0.0-b2
```

## Usage
```
$ docker run --name greenplum -p 5432:5432 -d andruche/greenplum:6.24.1
$ docker run --name greenplum -p 5432:5432 -d andruche/greenplum:7.0.0-b2
```
