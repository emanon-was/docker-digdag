FROM openjdk:8-jre-slim as download

# Digdag > Docs > Getting started
# https://docs.digdag.io/getting_started.html

RUN apt-get update \
  && apt-get install -y curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x /usr/local/bin/digdag

FROM openjdk:8-jre-slim

COPY --from=download /usr/local/bin/digdag /usr/local/bin/
COPY docker-entrypoint.sh /app/

WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
