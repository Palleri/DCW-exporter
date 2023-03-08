FROM alpine:3.15
ENV NOTIFY="" \
MAIN_DCW="" \
POSTGRES_PASSWORD=""
RUN apk --update add --no-cache \
    bash \
    curl \
    vim \
    grep \
    postgresql-client \
    && rm -rf /var/cache/apk/* 
    

COPY app* /app/ 
RUN adduser www-data -G www-data -H -s /bin/bash -D \
&& curl -L "https://download.docker.com/linux/static/stable/x86_64/docker-23.0.1.tgz" -o /app/docker.tgz \
&& curl -L "https://github.com/regclient/regclient/releases/download/v0.4.5/regctl-linux-amd64" -o /app/regctl 
#EXPOSE 80
#VOLUME /var/www


ENTRYPOINT [ "/app/entrypoint.sh" ]
