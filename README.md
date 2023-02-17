# docker-greenplum


## Build image
```
docker build -f DockerFile -t andruche/greenplum:6.23.1 .
```

## Usage
```
$ docker run --name greenplum -p 5432:5432  -d andruche/greenplum:6.23.1
```
