FROM alpine:latest

ENV ROOT_HOME=/root

RUN apk add --no-cache bash=4.3.48-r1

COPY root/* "${ROOT_HOME}"

WORKDIR /root

CMD ["/usr/bin/env", "bash"]
