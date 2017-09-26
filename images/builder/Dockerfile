ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache gcc=6.3.0-r4 \
                       jq=1.5-r3 \
                       make=4.2.1-r0

CMD ["/usr/bin/env", "bash"]
