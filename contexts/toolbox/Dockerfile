ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache jq \
                       vim

# Run in the background by default.
CMD ["-c", "trap 'exit 0' SIGTERM SIGINT; sleep infinity & wait"]
