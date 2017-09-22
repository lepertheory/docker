FROM builder:${GIT_BRANCH:-master}

COPY heimdal-4.7.0-fix-no-cdefs.patch /root/

RUN apk add --no-cache libc-dev \
                       ncurses-dev && \
    cd ~ && \
    wget 'https://github.com/heimdal/heimdal/releases/download/heimdal-7.4.0/heimdal-7.4.0.tar.gz' && \
    tar -xvf 'heimdal-7.4.0.tar.gz' && \
    cd 'heimdal-7.4.0' # && \
    #patch -p1 < ~/heimdal-7.4.0-fix-no-cdefs.patch && \
    #./configure && \
    #make

CMD ["/usr/bin/env", "bash"]
