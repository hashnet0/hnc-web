FROM hnc-base:latest
LABEL name="hnc-web"
LABEL description="HashNet Container for a web server"
LABEL maintainer="hashsploit <hashsploit@protonmail.com>"

ARG NGINX_WORKER_CONNECTIONS=1024
ARG NGINX_MULTI_ACCEPT=yes
ARG NGINX_WORKER_PRIORITY=-11

ENV NGINX_WORKER_CONNECTIONS $NGINX_WORKER_CONNECTIONS
ENV NGINX_MULTI_ACCEPT $NGINX_MULTI_ACCEPT
ENV NGINX_WORKER_PRIORITY $NGINX_WORKER_PRIORITY

# Install dependencies
RUN echo "Updating system ..." \
	&& apt-get update >/dev/null 2>&1 \
	&& echo "Installing dependencies ..." \
	&& apt-get install -y \
	ca-certificates \
	nginx \
	gettext \
	>/dev/null 2>&1


# Remove generated configs
RUN rm -rf /etc/nginx/sites-available/* /etc/nginx/sites-enabled/* /var/www/*


# Copy file system
COPY fs/ /


# Configure nginx
RUN cd /etc/nginx/ \
	&& envsubst '${NGINX_WORKER_CONNECTIONS},${NGINX_MULTI_ACCEPT},${NGINX_WORKER_PRIORITY}' < /etc/nginx/nginx.conf > /tmp/nginx.conf \
	&& mv /tmp/nginx.conf /etc/nginx/nginx.conf \
	&& openssl req -x509 -nodes \
		-newkey rsa:4096 \
		-keyout /etc/nginx/certs/default.key \
		-out /etc/nginx/certs/default.crt \
		-days 9999 \
		-subj "/C=US/ST=California/L=San Francisco/O=localhost/OU=Org/CN=localhost/emailAddress=root@localhost"

# Install docker-gen
ENV DOCKER_GEN_VERSION 0.7.4
RUN curl -s -L -o docker-gen.tar.gz https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xvzf docker-gen.tar.gz \
	&& rm docker-gen.tar.gz \
	&& chmod +x /usr/local/bin/docker-gen


# Expose service
EXPOSE 80
EXPOSE 443


# Set image starting point
CMD ["bash", "/srv/launch.sh"]
