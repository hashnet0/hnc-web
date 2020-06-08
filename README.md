# HashNet Container for a reverse proxy web server

This Docker image generates a high-performance nginx server
to use as a reverse-proxy web server for hosted web-applications.

This container dynamically generates configs using [docker-gen](https://github.com/jwilder/docker-gen) 
for other virtual host web containers.

## Installation

### 1. Configure image

- Configure image in the `settings.sh` file.
- If you have static sites you want to add, you can add their nginx `.config`'s in `fs/etc/nginx/conf.d/`. Do not name your config `dynamic.conf` as that is what is used by docker-gen.

### 2. Build the image

Run the `build.sh` file to generate the Docker image `hnc-web`.

### 2. Deploy the container

To spawn a temporary container run `test.sh`.
You can manually start the services via executing `/srv/launch.sh`.

To deploy a dedicated container run `deploy.sh`.
The dedicated container will also create a mounted volume which is mounted at `/etc/nginx` in the container. This volume can be useful if you need to manually backup/restore certs from the `/etc/nginx/certs` directory in the container.

From here on you can use `docker start hnc-web` and `docker stop hnc-web` to control the container.

