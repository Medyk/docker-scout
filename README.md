# docker-scout

## build

```
docker buildx create --name container --driver=docker-container
docker buildx build --platform linux/amd64,linux/arm64 -t medyk/docker-scout:1.13.0-alpine3.20 --builder=container --sbom=true --provenance=true --push .
```

## run

```
docker pull medyk/docker-scout:1.13.0-alpine3.20
# config.json and docker.sock must be readable for user 1000:1000
docker run -it --rm -v /home/user/.docker/config.json:/home/scout/.docker/config.json:ro -v /var/run/docker.sock:/var/run/docker.sock:ro medyk/docker-scout:1.13.0-alpine3.20 cves medyk/docker-scout:1.13.0-alpine3.20
```
