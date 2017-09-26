ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache coreutils=8.27-r0 \
                       jq=1.5-r3 \
                       vim=8.0.0595-r0

# Run in the background by default.
CMD ["/bin/bash", "-c", "trap : TERM INT; sleep infinity & wait"]
