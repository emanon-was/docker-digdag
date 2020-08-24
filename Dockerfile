FROM python:3.8-alpine as build.download
# Digdag > Docs > Getting started
# https://docs.digdag.io/getting_started.html
RUN apk add --no-cache curl
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x /usr/local/bin/digdag

FROM python:3.8-alpine as build.entrypoint
COPY ./docker-entrypoint /app
WORKDIR /app
RUN pip install -r requirements.txt \
  && python docker-entrypoint-gen.py > docker-entrypoint.sh \
  && chmod +x docker-entrypoint.sh

FROM openjdk:8-jre-alpine
COPY --from=build.download /usr/local/bin/digdag /usr/local/bin/
COPY --from=build.entrypoint /app/docker-entrypoint.sh /app/
WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
