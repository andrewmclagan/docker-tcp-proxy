FROM haproxy:1.9-alpine

ENTRYPOINT ["/magic-entrypoint", "/docker-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

RUN apk add --no-cache python3 cmd:pip3 &&\
    pip3 install --no-cache-dir dnspython

COPY magic-entrypoint.py /magic-entrypoint

ENV DEFAULT_TIMEOUT=15s

ENV NAMESERVERS="208.67.222.222 8.8.8.8 208.67.220.220 8.8.4.4" \
    LISTEN=:100 \
    PRE_RESOLVE=0 \
    TALK=talk:100 \
    TIMEOUT_CLIENT=$DEFAULT_TIMEOUT \
    TIMEOUT_CLIENT_FIN=$DEFAULT_TIMEOUT \
    TIMEOUT_CONNECT=$DEFAULT_TIMEOUT \
    TIMEOUT_SERVER=$DEFAULT_TIMEOUT \
    TIMEOUT_SERVER_FIN=$DEFAULT_TIMEOUT \
    TIMEOUT_TUNNEL=$DEFAULT_TIMEOUT \
    UDP=0 \
    VERBOSE=0

# Metadata
ARG VCS_REF
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vendor=Tecnativa \
      org.label-schema.license=Apache-2.0 \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.vcs-url="https://github.com/Tecnativa/docker-tcp-proxy"
