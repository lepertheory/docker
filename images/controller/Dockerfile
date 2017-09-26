ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache jq=1.5-r3 \
                       vim=8.0.0595-r0

# Run in the background by default.
CMD ["-c", "trap 'exit 0' SIGTERM SIGINT; sleep infinity & wait"]
