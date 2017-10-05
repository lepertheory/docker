ARG GIT_BRANCH
FROM base:${GIT_BRANCH:-master}

RUN apk add --no-cache gcc \
                       make

CMD ["/usr/bin/env", "bash"]
