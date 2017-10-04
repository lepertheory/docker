ARG GIT_BRANCH=master
FROM lepertheory:${GIT_BRANCH}

COPY krb5.conf /etc/

RUN apk add --no-cache heimdal \
                       heimdal-dev \
                       heimdal-doc \
                       heimdal-libs && \
    mkdir /var/heimdal

CMD ["/usr/bin/env", "bash"]
