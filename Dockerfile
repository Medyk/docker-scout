ARG ALPINE_VERSION=3.20

FROM alpine:${ALPINE_VERSION}

ARG SCOUT_VERSION=1.13.0
ARG TARGETPLATFORM
ARG BUILDPLATFORM

# docker-cli
RUN apk upgrade \
    && apk add curl tar \
    && adduser -D scout \
    && mkdir -p /home/scout/.docker/scout \
    && chown -R scout:scout /home/scout \
    && download_dir=$(mktemp -d) \
    && curl -fsSL "https://github.com/docker/scout-cli/releases/download/v${SCOUT_VERSION}/docker-scout_${SCOUT_VERSION}_linux_${TARGETPLATFORM##linux/}.tar.gz" -o "$download_dir/docker-scout.tar.gz" \
    && tar --no-same-owner -xzvf "$download_dir/docker-scout.tar.gz" -C "$download_dir" \
    && mkdir -p "/usr/libexec/docker/cli-plugins/" \
    && mv "$download_dir/docker-scout" "/usr/libexec/docker/cli-plugins/" \
    && mkdir -p /usr/bin \
    && ln -sfv /usr/libexec/docker/cli-plugins/docker-scout /usr/bin/docker-scout \
    && apk del curl tar \
    && rm -rf -- "$download_dir" \
    && rm -rf -- /var/cache/apk/*

USER scout

ENTRYPOINT [ "docker-scout" ]
