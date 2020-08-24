#!/bin/sh

DIGDAG_CONFIG=$(dirname $0)/server.properties

if [ -f $DIGDAG_CONFIG ]; then
    rm $DIGDAG_CONFIG
fi

# Server-mode commands > --config
# https://docs.digdag.io/command_reference.html#server-mode-commands

# server.bind (ip address)
if [ -n "$SERVER_BIND" ]; then
    echo "server.bind = $SERVER_BIND" >> $DIGDAG_CONFIG
else
    echo "server.bind = 0.0.0.0" >> $DIGDAG_CONFIG
fi

# server.port (integer)
if [ -n "$SERVER_PORT" ]; then
    echo "server.port = $SERVER_PORT" >> $DIGDAG_CONFIG
else
    echo "server.port = 80" >> $DIGDAG_CONFIG
fi

# server.admin.bind (ip address)
if [ -n "$SERVER_ADMIN_BIND" ]; then
    echo "server.admin.bind = $SERVER_ADMIN_BIND" >> $DIGDAG_CONFIG
fi

# server.admin.port (integer)
if [ -n "$SERVER_ADMIN_PORT" ]; then
    echo "server.admin.port = $SERVER_ADMIN_PORT" >> $DIGDAG_CONFIG
fi

# server.access-log.path (string. same with –access-log)
if [ -n "$SERVER_ACCESS_LOG_PATH" ]; then
    echo "server.access-log.path = $SERVER_ACCESS_LOG_PATH" >> $DIGDAG_CONFIG
fi

# server.access-log.pattern (string, "json", "combined" or "common")
if [ -n "$SERVER_ACCESS_LOG_PATTERN" ]; then
    case "$SERVER_ACCESS_LOG_PATTERN" in
        json | combined | common )
            echo "server.access-log.pattern = $SERVER_ACCESS_LOG_PATTERN" >> $DIGDAG_CONFIG
            ;;
        * ) echo "Invalid parameter: SERVER_ACCESS_LOG_PATTERN = [json, combined, common]"
            exit 1
            ;;
    esac
fi

# server.http.io-threads (number of HTTP IO threads in integer. default: available CPU cores or 2, whichever is greater)
if [ -n "$SERVER_HTTP_IO_THREADS" ]; then
    echo "server.http.io-threads = $SERVER_HTTP_IO_THREADS" >> $DIGDAG_CONFIG
fi

# server.http.worker-threads (number of HTTP worker threads in integer. default: server.http.io-threads * 8)
if [ -n "$SERVER_HTTP_WORKER_THREADS" ]; then
    echo "server.http.worker-threads = $SERVER_HTTP_WORKER_THREADS" >> $DIGDAG_CONFIG
fi

# server.http.no-request-timeout (maximum allowed time for clients to keep a connection open without sending requests or receiving responses in seconds. default: 60)
if [ -n "$SERVER_HTTP_NO_REQUEST_TIMEOUT" ]; then
    echo "server.http.no-request-timeout = $SERVER_HTTP_NO_REQUEST_TIMEOUT" >> $DIGDAG_CONFIG
fi

# server.http.request-parse-timeout (maximum allowed time of reading a HTTP request in seconds. this doesn’t affect on reading request body. default: 30)
if [ -n "$SERVER_HTTP_REQUEST_PARSE_TIMEOUT" ]; then
    echo "server.http.request-parse-timeout = $SERVER_HTTP_REQUEST_PARSE_TIMEOUT" >> $DIGDAG_CONFIG
fi

# server.http.io-idle-timeout (maximum allowed idle time of reading HTTP request and writing HTTP response in seconds. default: 300)
if [ -n "$SERVER_HTTP_IO_IDLE_TIMEOUT" ]; then
    echo "server.http.io-idle-timeout = $SERVER_HTTP_IO_IDLE_TIMEOUT" >> $DIGDAG_CONFIG
fi

# server.http.enable-http2 (enable HTTP/2. default: false)
if [ -n "$SERVER_HTTP_ENABLE_HTTP2" ]; then
    echo "server.http.enable-http2 = $SERVER_HTTP_ENABLE_HTTP2" >> $DIGDAG_CONFIG
fi

# server.jmx.port (port to listen JMX in integer. default: JMX is disabled) Since Java 9, to use this option, you need to set '-Djdk.attach.allowAttachSelf=true' to command line option of java or to JDK_JAVA_OPTIONS environment variable.
if [ -n "$SERVER_JMX_PORT" ]; then
    echo "server.jmx.port = $SERVER_JMX_PORT" >> $DIGDAG_CONFIG
fi

# server.authenticator-class (string) The FQCN of the io.digdag.spi.Authenticator implementation to use. The implementation is to be provided by a system plugin. The auth plugin configuration is implementation specific. Default: io.digdag.standards.auth.jwt.JwtAuthenticator
if [ -n "$SERVER_AUTHENTICATOR_CLASS" ]; then
    echo "server.authenticator-class = $SERVER_AUTHENTICATOR_CLASS" >> $DIGDAG_CONFIG
fi

# database.type (enum, "h2" or "postgresql")
if [ -n "$DATABASE_TYPE" ]; then
    case "$DATABASE_TYPE" in
        h2 | postgresql )
            echo "database.type = $DATABASE_TYPE" >> $DIGDAG_CONFIG
            ;;
        * ) echo "Invalid parameter: DATABASE_TYPE = [h2, postgresql]"
            exit 1
            ;;
    esac
fi

# database.user (string)
if [ -n "$DATABASE_USER" ]; then
    echo "database.user = $DATABASE_USER" >> $DIGDAG_CONFIG
fi

# database.password (string)
if [ -n "$DATABASE_PASSWORD" ]; then
    echo "database.password = $DATABASE_PASSWORD" >> $DIGDAG_CONFIG
fi

# database.host (string)
if [ -n "$DATABASE_HOST" ]; then
    echo "database.host = $DATABASE_HOST" >> $DIGDAG_CONFIG
fi

# database.port (integer)
if [ -n "$DATABASE_PORT" ]; then
    echo "database.port = $DATABASE_PORT" >> $DIGDAG_CONFIG
fi

# database.database (string)
if [ -n "$DATABASE_DATABASE" ]; then
    echo "database.database = $DATABASE_DATABASE" >> $DIGDAG_CONFIG
fi

# database.loginTimeout (seconds in integer, default: 30)
if [ -n "$DATABASE_LOGIN_TIMEOUT" ]; then
    echo "database.loginTimeout = $DATABASE_LOGIN_TIMEOUT" >> $DIGDAG_CONFIG
fi

# database.socketTimeout (seconds in integer, default: 1800)
if [ -n "$DATABASE_SOCKET_TIMEOUT" ]; then
    echo "database.socketTimeout = $DATABASE_SOCKET_TIMEOUT" >> $DIGDAG_CONFIG
fi

# database.ssl (boolean, default: false)
if [ -n "$DATABASE_SSL" ]; then
    echo "database.ssl = $DATABASE_SSL" >> $DIGDAG_CONFIG
fi

# database.connectionTimeout (seconds in integer, default: 30)
if [ -n "$DATABASE_CONNECTION_TIMEOUT" ]; then
    echo "database.connectionTimeout = $DATABASE_CONNECTION_TIMEOUT" >> $DIGDAG_CONFIG
fi

# database.idleTimeout (seconds in integer, default: 600)
if [ -n "$DATABASE_IDLE_TIMEOUT" ]; then
    echo "database.idleTimeout = $DATABASE_IDLE_TIMEOUT" >> $DIGDAG_CONFIG
fi

# database.validationTimeout (seconds in integer, default: 5)
if [ -n "$DATABASE_VALIDATION_TIMEOUT" ]; then
    echo "database.validationTimeout = $DATABASE_VALIDATION_TIMEOUT" >> $DIGDAG_CONFIG
fi

# database.maximumPoolSize (integer, default: available CPU cores * 32)
if [ -n "$DATABASE_MAXIMUM_POOL_SIZE" ]; then
    echo "database.maximumPoolSize = $DATABASE_MAXIMUM_POOL_SIZE" >> $DIGDAG_CONFIG
fi

# database.minimumPoolSize (integer, default: same as database.maximumPoolSize)
if [ -n "$DATABASE_MINIMUM_POOL_SIZE" ]; then
    echo "database.minimumPoolSize = $DATABASE_MINIMUM_POOL_SIZE" >> $DIGDAG_CONFIG
fi

# database.leakDetectionThreshold (HikariCP leakDetectionThreshold milliseconds in integer. default: 0. To enable, set to >= 2000.)
if [ -n "$DATABASE_LEAK_DETECTION_THRESHOLD" ]; then
    echo "database.leakDetectionThreshold = $DATABASE_LEAK_DETECTION_THRESHOLD" >> $DIGDAG_CONFIG
fi

# database.migrate (enable DB migration. default: true)
if [ -n "$DATABASE_MIGRATE" ]; then
    echo "database.migrate = $DATABASE_MIGRATE" >> $DIGDAG_CONFIG
fi

# archive.type (type of project archiving, "db", "s3" or "gcs". default: "db")
if [ -n "$ARCHIVE_TYPE" ]; then
    case "$ARCHIVE_TYPE" in
        db | s3 | gcs )
            echo "archive.type = $ARCHIVE_TYPE" >> $DIGDAG_CONFIG
            ;;
        * ) echo "Invalid parameter: ARCHIVE_TYPE = [db, s3, gcs]"
            exit 1
            ;;
    esac
fi

# archive.s3.endpoint (string. default: "s3.amazonaws.com")
if [ -n "$ARCHIVE_S3_ENDPOINT" ]; then
    echo "archive.s3.endpoint = $ARCHIVE_S3_ENDPOINT" >> $DIGDAG_CONFIG
fi

# archive.s3.bucket (string)
if [ -n "$ARCHIVE_S3_BUCKET" ]; then
    echo "archive.s3.bucket = $ARCHIVE_S3_BUCKET" >> $DIGDAG_CONFIG
fi

# archive.s3.path (string)
if [ -n "$ARCHIVE_S3_PATH" ]; then
    echo "archive.s3.path = $ARCHIVE_S3_PATH" >> $DIGDAG_CONFIG
fi

# archive.s3.credentials.access-key-id (string. default: instance profile)
if [ -n "$ARCHIVE_S3_CREDENTIALS_ACCESS_KEY_ID" ]; then
    echo "archive.s3.credentials.access-key-id = $ARCHIVE_S3_CREDENTIALS_ACCESS_KEY_ID" >> $DIGDAG_CONFIG
fi

# archive.s3.credentials.secret-access-key (string. default: instance profile)
if [ -n "$ARCHIVE_S3_CREDENTIALS_SECRET_ACCESS_KEY" ]; then
    echo "archive.s3.credentials.secret-access-key = $ARCHIVE_S3_CREDENTIALS_SECRET_ACCESS_KEY" >> $DIGDAG_CONFIG
fi

# archive.s3.path-style-access (boolean. default: false)
if [ -n "$ARCHIVE_S3_PATH_STYLE_ACCESS" ]; then
    echo "archive.s3.path-style-access = $ARCHIVE_S3_PATH_STYLE_ACCESS" >> $DIGDAG_CONFIG
fi

# archive.gcs.bucket (string)
if [ -n "$ARCHIVE_GCS_BUCKET" ]; then
    echo "archive.gcs.bucket = $ARCHIVE_GCS_BUCKET" >> $DIGDAG_CONFIG
fi

# archive.gcs.credentials.json.path (string. if not set, auth with local authentication information. Also if path and content are set, path has priority.)
if [ -n "$ARCHIVE_GCS_CREDENTIALS_JSON_PATH" ]; then
    echo "archive.gcs.credentials.json.path = $ARCHIVE_GCS_CREDENTIALS_JSON_PATH" >> $DIGDAG_CONFIG
fi

# archive.gcs.credentials.json.content (string. if not set, auth with local authentication information. Also if path and content are set, path has priority.)
if [ -n "$ARCHIVE_GCS_CREDENTIALS_JSON_CONTENT" ]; then
    echo "archive.gcs.credentials.json.content = $ARCHIVE_GCS_CREDENTIALS_JSON_CONTENT" >> $DIGDAG_CONFIG
fi

# log-server.type (type of log storage, "local" , "null", "s3" or "gcs". default: "null". This parameter will be overwritten with "local" if -O, --task-log DIR is set.)
if [ -n "$LOG_SERVER_TYPE" ]; then
    case "$LOG_SERVER_TYPE" in
        local | null | s3 | gcs )
            echo "log-server.type = $LOG_SERVER_TYPE" >> $DIGDAG_CONFIG
            ;;
        * ) echo "Invalid parameter: LOG_SERVER_TYPE = [local, null, s3, gcs]"
            exit 1
            ;;
    esac
fi

# log-server.s3.endpoint (string, default: "s3.amazonaws.com")
if [ -n "$LOG_SERVER_S3_ENDPOINT" ]; then
    echo "log-server.s3.endpoint = $LOG_SERVER_S3_ENDPOINT" >> $DIGDAG_CONFIG
fi

# log-server.s3.bucket (string)
if [ -n "$LOG_SERVER_S3_BUCKET" ]; then
    echo "log-server.s3.bucket = $LOG_SERVER_S3_BUCKET" >> $DIGDAG_CONFIG
fi

# log-server.s3.path (string)
if [ -n "$LOG_SERVER_S3_PATH" ]; then
    echo "log-server.s3.path = $LOG_SERVER_S3_PATH" >> $DIGDAG_CONFIG
fi

# log-server.s3.direct_download (boolean. default: false)
if [ -n "$LOG_SERVER_S3_DIRECT_DOWNLOAD" ]; then
    echo "log-server.s3.direct_download = $LOG_SERVER_S3_DIRECT_DOWNLOAD" >> $DIGDAG_CONFIG
fi

# log-server.s3.credentials.access-key-id (string. default: instance profile)
if [ -n "$LOG_SERVER_S3_CREDENTIALS_ACCESS_KEY_ID" ]; then
    echo "log-server.s3.credentials.access-key-id = $LOG_SERVER_S3_CREDENTIALS_ACCESS_KEY_ID" >> $DIGDAG_CONFIG
fi

# log-server.s3.credentials.secret-access-key (string. default: instance profile)
if [ -n "$LOG_SERVER_S3_CREDENTIALS_SECRET_ACCESS_KEY" ]; then
    echo "log-server.s3.credentials.secret-access-key = $LOG_SERVER_S3_CREDENTIALS_SECRET_ACCESS_KEY" >> $DIGDAG_CONFIG
fi

# log-server.s3.path-style-access (boolean. default: false)
if [ -n "$LOG_SERVER_S3_PATH_STYLE_ACCESS" ]; then
    echo "log-server.s3.path-style-access = $LOG_SERVER_S3_PATH_STYLE_ACCESS" >> $DIGDAG_CONFIG
fi

# log-server.gcs.bucket (string)
if [ -n "$LOG_SERVER_GCS_BUCKET" ]; then
    echo "log-server.gcs.bucket = $LOG_SERVER_GCS_BUCKET" >> $DIGDAG_CONFIG
fi

# log-server.gcs.credentials.json.path (string. if not set, auth with local authentication information. Also if path and content are set, path has priority.)
if [ -n "$LOG_SERVER_GCS_CREDENTIALS_JSON_PATH" ]; then
    echo "log-server.gcs.credentials.json.path = $LOG_SERVER_GCS_CREDENTIALS_JSON_PATH" >> $DIGDAG_CONFIG
fi

# log-server.gcs.credentials.json.content (string. if not set, auth with local authentication information. Also if path and content are set, path has priority.)
if [ -n "$LOG_SERVER_GCS_CREDENTIALS_JSON_CONTENT" ]; then
    echo "log-server.gcs.credentials.json.content = $LOG_SERVER_GCS_CREDENTIALS_JSON_CONTENT" >> $DIGDAG_CONFIG
fi

# log-server.local.path (string. default: digdag.log)
if [ -n "$LOG_SERVER_LOCAL_PATH" ]; then
    echo "log-server.local.path = $LOG_SERVER_LOCAL_PATH" >> $DIGDAG_CONFIG
fi

# log-server.local.split_size (long. max log file size in bytes(uncompressed). default: 0 (not splitted))
if [ -n "$LOG_SERVER_LOCAL_SPLIT_SIZE" ]; then
    echo "log-server.local.split_size = $LOG_SERVER_LOCAL_SPLIT_SIZE" >> $DIGDAG_CONFIG
fi

# digdag.secret-encryption-key (base64 encoded 128-bit AES encryption key)
if [ -n "$DIGDAG_SECRET_ENCRYPTION_KEY" ]; then
    echo "digdag.secret-encryption-key = $DIGDAG_SECRET_ENCRYPTION_KEY" >> $DIGDAG_CONFIG
fi

# executor.task_ttl (string. default: 1d. A task is killed if it is running longer than this period.)
if [ -n "$EXECUTOR_TASK_TTL" ]; then
    echo "executor.task_ttl = $EXECUTOR_TASK_TTL" >> $DIGDAG_CONFIG
fi

# executor.attempt_ttl (string. default: 7d. An attempt is killed if it is running longer than this period.)
if [ -n "$EXECUTOR_ATTEMPT_TTL" ]; then
    echo "executor.attempt_ttl = $EXECUTOR_ATTEMPT_TTL" >> $DIGDAG_CONFIG
fi

# api.max_attempts_page_size (integer. The max number of rows of attempts in api response)
if [ -n "$API_MAX_ATTEMPTS_PAGE_SIZE" ]; then
    echo "api.max_attempts_page_size = $API_MAX_ATTEMPTS_PAGE_SIZE" >> $DIGDAG_CONFIG
fi

# api.max_sessions_page_size (integer. The max number of rows of sessions in api response)
if [ -n "$API_MAX_SESSIONS_PAGE_SIZE" ]; then
    echo "api.max_sessions_page_size = $API_MAX_SESSIONS_PAGE_SIZE" >> $DIGDAG_CONFIG
fi




# Start digdag server

if [ -f $DIGDAG_CONFIG ]; then
    digdag server --config $DIGDAG_CONFIG $@
else
    digdag server --memory $@
fi
