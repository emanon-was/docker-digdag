# docker-digdag-server

## How to use this image

### Start a `digdag server` instance

Starting a Digdag instance is simple:
```shell
$ docker run -d --name some-digdag -e SERVER_PORT=65432 digdag-server:tag
```

### Commands

```
--disable-executor-loop      disable workflow executor loop
--disable-scheduler          disable scheduler
--disable-local-agent        disable local task execution
--enable-swagger             enable swagger api. Do not use in production because CORS
                             is also enabled on from any domains with all HTTP methods
```

If you need only WebUI/API

```shell
$ docker run -d --name some-digdag -e .... digdag-server:tag --disable-local-agent --disable-executor-loop --disable-scheduler
```

If you need Agent/Workflow/Scheduler

```shell
$ docker run -d --name some-digdag -e .... digdag-server:tag
```

### Environment Variables

Read `docker-entrypoint/digdag-server.toml`

```toml
# docker-entrypoint/digdag-server.toml

# Server-mode commands > --config
# https://docs.digdag.io/command_reference.html#server-mode-commands

[SERVER_BIND]
param = "server.bind"
about = "ip address"
default = "0.0.0.0"

[SERVER_PORT]
param = "server.port"
about = "integer"
default = 80

[SERVER_ADMIN_BIND]
param = "server.admin.bind"
about = "ip address"

[SERVER_ADMIN_PORT]
param = "server.admin.port"
about = "integer"

[SERVER_ACCESS_LOG_PATH]
param = "server.access-log.path"
about = "string. same with –access-log"

[SERVER_ACCESS_LOG_PATTERN]
param = "server.access-log.pattern"
about = "string, \"json\", \"combined\" or \"common\""
enum  = ["json", "combined", "common"]

[SERVER_HTTP_IO_THREADS]
param = "server.http.io-threads"
about = "number of HTTP IO threads in integer. default: available CPU cores or 2, whichever is greater"

[SERVER_HTTP_WORKER_THREADS]
param = "server.http.worker-threads"
about = "number of HTTP worker threads in integer. default: server.http.io-threads * 8"

[SERVER_HTTP_NO_REQUEST_TIMEOUT]
param = "server.http.no-request-timeout"
about = "maximum allowed time for clients to keep a connection open without sending requests or receiving responses in seconds. default: 60"

[SERVER_HTTP_REQUEST_PARSE_TIMEOUT]
param = "server.http.request-parse-timeout"
about = "maximum allowed time of reading a HTTP request in seconds. this doesn’t affect on reading request body. default: 30"

[SERVER_HTTP_IO_IDLE_TIMEOUT]
param = "server.http.io-idle-timeout"
about = "maximum allowed idle time of reading HTTP request and writing HTTP response in seconds. default: 300"

[SERVER_HTTP_ENABLE_HTTP2]
param = "server.http.enable-http2"
about = "enable HTTP/2. default: false"

# TODO:
# [SERVER_HTTP_HEADERS]
# param = "server.http.headers.KEY = VALUE"
# about = "HTTP header to set on API responses"

[SERVER_JMX_PORT]
param = "server.jmx.port"
about = "port to listen JMX in integer. default: JMX is disabled"
warn  = "Since Java 9, to use this option, you need to set '-Djdk.attach.allowAttachSelf=true' to command line option of java or to JDK_JAVA_OPTIONS environment variable."

[SERVER_AUTHENTICATOR_CLASS]
param = "server.authenticator-class"
about = "string"
warn  = "The FQCN of the io.digdag.spi.Authenticator implementation to use. The implementation is to be provided by a system plugin. The auth plugin configuration is implementation specific. Default: io.digdag.standards.auth.jwt.JwtAuthenticator"

[DATABASE_TYPE]
param = "database.type"
about = "enum, \"h2\" or \"postgresql\""
enum  = ["h2", "postgresql"]

[DATABASE_USER]
param = "database.user"
about = "string"

[DATABASE_PASSWORD]
param = "database.password"
about = "string"

[DATABASE_HOST]
param = "database.host"
about = "string"

[DATABASE_PORT]
param = "database.port"
about = "integer"

[DATABASE_DATABASE]
param = "database.database"
about = "string"

[DATABASE_LOGIN_TIMEOUT]
param = "database.loginTimeout"
about = "seconds in integer, default: 30"

[DATABASE_SOCKET_TIMEOUT]
param = "database.socketTimeout"
about = "seconds in integer, default: 1800"

[DATABASE_SSL]
param = "database.ssl"
about = "boolean, default: false"

[DATABASE_CONNECTION_TIMEOUT]
param = "database.connectionTimeout"
about = "seconds in integer, default: 30"

[DATABASE_IDLE_TIMEOUT]
param = "database.idleTimeout"
about = "seconds in integer, default: 600"

[DATABASE_VALIDATION_TIMEOUT]
param = "database.validationTimeout"
about = "seconds in integer, default: 5"

[DATABASE_MAXIMUM_POOL_SIZE]
param = "database.maximumPoolSize"
about = "integer, default: available CPU cores * 32"

[DATABASE_MINIMUM_POOL_SIZE]
param = "database.minimumPoolSize"
about = "integer, default: same as database.maximumPoolSize"

[DATABASE_LEAK_DETECTION_THRESHOLD]
param = "database.leakDetectionThreshold"
about = "HikariCP leakDetectionThreshold milliseconds in integer. default: 0. To enable, set to >= 2000."

[DATABASE_MIGRATE]
param = "database.migrate"
about = "enable DB migration. default: true"

[ARCHIVE_TYPE]
param = "archive.type"
about = "type of project archiving, \"db\", \"s3\" or \"gcs\". default: \"db\""
enum  = ["db", "s3", "gcs"]

[ARCHIVE_S3_ENDPOINT]
param = "archive.s3.endpoint"
about = "string. default: \"s3.amazonaws.com\""

[ARCHIVE_S3_BUCKET]
param = "archive.s3.bucket"
about = "string"

[ARCHIVE_S3_PATH]
param = "archive.s3.path"
about = "string"

[ARCHIVE_S3_CREDENTIALS_ACCESS_KEY_ID]
param = "archive.s3.credentials.access-key-id"
about = "string. default: instance profile"

[ARCHIVE_S3_CREDENTIALS_SECRET_ACCESS_KEY]
param = "archive.s3.credentials.secret-access-key"
about = "string. default: instance profile"

[ARCHIVE_S3_PATH_STYLE_ACCESS]
param = "archive.s3.path-style-access"
about = "boolean. default: false"

[ARCHIVE_GCS_BUCKET]
param = "archive.gcs.bucket"
about = "string"

[ARCHIVE_GCS_CREDENTIALS_JSON_PATH]
param = "archive.gcs.credentials.json.path"
about = "string. if not set, auth with local authentication information. Also if path and content are set, path has priority."

[ARCHIVE_GCS_CREDENTIALS_JSON_CONTENT]
param = "archive.gcs.credentials.json.content"
about = "string. if not set, auth with local authentication information. Also if path and content are set, path has priority."

[LOG_SERVER_TYPE]
param = "log-server.type"
about = "type of log storage, \"local\" , \"null\", \"s3\" or \"gcs\". default: \"null\". This parameter will be overwritten with \"local\" if -O, --task-log DIR is set."
enum  = ["local", "null", "s3", "gcs"]

[LOG_SERVER_S3_ENDPOINT]
param = "log-server.s3.endpoint"
about = "string, default: \"s3.amazonaws.com\""

[LOG_SERVER_S3_BUCKET]
param = "log-server.s3.bucket"
about = "string"

[LOG_SERVER_S3_PATH]
param = "log-server.s3.path"
about = "string"

[LOG_SERVER_S3_DIRECT_DOWNLOAD]
param = "log-server.s3.direct_download"
about = "boolean. default: false"

[LOG_SERVER_S3_CREDENTIALS_ACCESS_KEY_ID]
param = "log-server.s3.credentials.access-key-id"
about = "string. default: instance profile"

[LOG_SERVER_S3_CREDENTIALS_SECRET_ACCESS_KEY]
param = "log-server.s3.credentials.secret-access-key"
about = "string. default: instance profile"

[LOG_SERVER_S3_PATH_STYLE_ACCESS]
param = "log-server.s3.path-style-access"
about = "boolean. default: false"

[LOG_SERVER_GCS_BUCKET]
param = "log-server.gcs.bucket"
about = "string"

[LOG_SERVER_GCS_CREDENTIALS_JSON_PATH]
param = "log-server.gcs.credentials.json.path"
about = "string. if not set, auth with local authentication information. Also if path and content are set, path has priority."

[LOG_SERVER_GCS_CREDENTIALS_JSON_CONTENT]
param = "log-server.gcs.credentials.json.content"
about = "string. if not set, auth with local authentication information. Also if path and content are set, path has priority."

[LOG_SERVER_LOCAL_PATH]
param = "log-server.local.path"
about = "string. default: digdag.log"

[LOG_SERVER_LOCAL_SPLIT_SIZE]
param = "log-server.local.split_size"
about = "long. max log file size in bytes(uncompressed). default: 0 (not splitted)"

[DIGDAG_SECRET_ENCRYPTION_KEY]
param = "digdag.secret-encryption-key"
about = "base64 encoded 128-bit AES encryption key"

[EXECUTOR_TASK_TTL]
param = "executor.task_ttl"
about = "string. default: 1d. A task is killed if it is running longer than this period."

[EXECUTOR_ATTEMPT_TTL]
param = "executor.attempt_ttl"
about = "string. default: 7d. An attempt is killed if it is running longer than this period."

[API_MAX_ATTEMPTS_PAGE_SIZE]
param = "api.max_attempts_page_size"
about = "integer. The max number of rows of attempts in api response"

[API_MAX_SESSIONS_PAGE_SIZE]
param = "api.max_sessions_page_size"
about = "integer. The max number of rows of sessions in api response"
```