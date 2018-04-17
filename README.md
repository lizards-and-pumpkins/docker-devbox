# Lizards & Pumpkins Docker DevBox


## Run with docker-compose
Edit `docker-compose.yaml` and set `BASE_URL`, `PORT` according to your needs.

```
docker-compose up -d
```

## Run docker container

```
docker run --name lizards-devbox -p 127.0.0.1:8080:80 --env BASE_URL=127.0.0.1 --env PORT=8080 --env PROTO=http -tid lizardsandpumpkins/devbox:0.4
```

## Build new docker image

```
docker build -t lizardsandpumpkins/devbox:<version> .
```
