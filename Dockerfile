FROM python:3.8-alpine as build.download

# Releases
# https://docs.digdag.io/releases.html

ARG VERSION
ENV VERSION ${VERSION:-latest}

# Digdag > Docs > Getting started
# https://docs.digdag.io/getting_started.html

RUN apk add --no-cache curl
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${VERSION}" \
  && chmod +x /usr/local/bin/digdag

FROM python:3.8-alpine as build.entrypoint
COPY ./docker-entrypoint /app
WORKDIR /app
RUN pip install -r requirements.txt \
  && python build.py > docker-entrypoint.sh \
  && chmod +x docker-entrypoint.sh

FROM python:3.8-alpine
RUN apk add --no-cache openjdk8-jre
COPY ./requirements.txt /app/
RUN pip install --upgrade -r /app/requirements.txt
COPY --from=build.download /usr/local/bin/digdag /usr/local/bin/
COPY --from=build.entrypoint /app/docker-entrypoint.sh /app/
WORKDIR /app
ENTRYPOINT ["/app/docker-entrypoint.sh"]
