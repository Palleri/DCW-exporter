FROM alpine:3.21
ARG TARGETPLATFORM
ENV NOTIFY="" \
MAIN_DCW="" \
TOKEN=""
COPY app* /app/ 
RUN case "${TARGETPLATFORM}" in \
        "linux/amd64")  os="amd64";   dockeros="x86_64"  ;; \
        "linux/arm64")  os="arm64";   dockeros="aarch64" ;; \
        *) echo "Unsupported TARGETPLATFORM: ${TARGETPLATFORM}" && exit 1 ;; \
    esac \
&& wget "https://download.docker.com/linux/static/stable/${dockeros}/docker-29.0.4.tgz" -O /app/docker.tgz \
&& wget "https://github.com/regclient/regclient/releases/download/v0.10.0/regctl-linux-${os}" -O /app/regctl \
&& apk --update add --no-cache \
    bash \
    curl \
    vim \
    grep \
    postgresql-client \
    && rm -rf /var/cache/apk/* \
&& adduser www-data -G www-data -H -s /bin/bash -D \
&& cd /app \
&& tar xzvf docker.tgz > /dev/null 2>&1 \
&& cp docker/* /usr/bin/ > /dev/null 2>&1 \
&& chmod +x dockcheck* \
&& chmod +x regctl \
&& cp regctl /usr/bin/regctl

ENTRYPOINT [ "/app/entrypoint.sh" ]
