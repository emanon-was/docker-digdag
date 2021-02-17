FROM alpine:latest as build.download

# Releases
# https://docs.digdag.io/releases.html

ARG VERSION
ENV VERSION ${VERSION:-latest}

# Digdag > Docs > Getting started
# https://docs.digdag.io/getting_started.html

RUN apk add --no-cache curl
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${VERSION}" \
  && chmod +x /usr/local/bin/digdag


FROM alpine:latest
RUN apk add --no-cache openjdk8-jre
COPY --from=build.download /usr/local/bin/digdag /usr/local/bin/
COPY ./entrypoint.sh /app/
WORKDIR /app
ENTRYPOINT ["/app/entrypoint.sh"]
