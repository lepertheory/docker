#ARG GIT_BRANCH
#FROM base:${GIT_BRANCH:-master}
FROM base:master

RUN apk add --no-cache jq \
                       tmux \
                       vim

VOLUME /mnt/root

# Run in the background by default.
CMD ["-c", "trap 'exit 0' SIGTERM SIGINT; sleep infinity & wait"]
