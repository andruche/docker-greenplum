# docker-greenplum

Difference from datagrip version:
* Fast start (~ 2 sec) due to pre-initialization of the cluster on build stage
* Support Apple M1 processor
* Correct stop
* Printing greenplum logs to container logs

GPORCA optimizer temporarily disabled (some compilation problems)

## Build images

The build process supports a `SEGMENT_COUNT` build argument to configure the number of primary segments (default: 2, range: 1-16).

```bash
# Build with default 2 segments
$ docker buildx build --platform linux/arm64/v8 -f 6/DockerFile -t andruche/greenplum:6.25.3-slim-arm64 .
$ docker push andruche/greenplum:6.25.3-slim-arm64
$ docker buildx build --platform linux/amd64 -f 6/DockerFile -t andruche/greenplum:6.25.3-slim-amd64 .
$ docker push andruche/greenplum:6.25.3-slim-amd64

# Build with custom segment count (e.g., 4 segments)
$ docker buildx build --platform linux/arm64/v8 -f 6/DockerFile --build-arg SEGMENT_COUNT=4 -t andruche/greenplum:6.25.3-slim-arm64 .

$ docker buildx build --platform linux/arm64/v8 -f 7/DockerFile -t andruche/greenplum:7.0.0-slim-arm64 .
$ docker push andruche/greenplum:7.0.0-slim-arm64
$ docker buildx build --platform linux/amd64 -f 7/DockerFile -t andruche/greenplum:7.0.0-slim-amd64 .
$ docker push andruche/greenplum:7.0.0-slim-amd64
```

## Build manifests
```
$ docker manifest rm andruche/greenplum:6.25.3
$ docker manifest create andruche/greenplum:6.25.3 --amend andruche/greenplum:6.25.3-slim-arm64 --amend andruche/greenplum:6.25.3-slim-amd64
$ docker manifest push andruche/greenplum:6.25.3

$ docker manifest rm andruche/greenplum:7.0.0
$ docker manifest create andruche/greenplum:7.0.0 --amend andruche/greenplum:7.0.0-slim-arm64 --amend andruche/greenplum:7.0.0-slim-amd64
$ docker manifest push andruche/greenplum:7.0.0
```

## Usage
```bash
$ docker run --name greenplum -p 5432:5432 -d andruche/greenplum:6
$ docker run --name greenplum -p 5432:5432 -d andruche/greenplum:7
```

## Configuring Segment Count

The number of primary segments can be configured at build time using the `SEGMENT_COUNT` build argument:

- **Default**: 2 segments
- **Range**: 1-16 segments
- **Purpose**: More segments can improve parallelism for larger datasets, while fewer segments reduce overhead for smaller workloads

Example with 4 segments:
```bash
$ docker buildx build --platform linux/amd64 -f 6/DockerFile --build-arg SEGMENT_COUNT=4 -t greenplum:6-custom .
$ docker run --name greenplum -p 5432:5432 -d greenplum:6-custom
```

**Note**: Segment count is configured at build time and cannot be changed after the image is built. Each segment will have its own data directory (`/data/data1`, `/data/data2`, etc.).
