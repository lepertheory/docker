FROM alpine:latest

ENV ROOT_HOME=/root

RUN apk add --no-cache bash=4.3.48-r1 \
                       less=487-r0

COPY root/* "${ROOT_HOME}"

WORKDIR "${ROOT_HOME}"

CMD ["/usr/bin/env", "bash"]
