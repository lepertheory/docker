ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache coreutils=8.27-r0 \
                       jq=1.5-r3 \
                       vim=8.0.0595-r0

COPY common /usr/local/bin

# Soon.
CMD ["/bin/bash", "-ic", "trap : TERM INT; sleep infinity & wait"]
