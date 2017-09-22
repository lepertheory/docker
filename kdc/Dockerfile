FROM builder:${GIT_BRANCH:-master}

COPY heimdal-7.4.0.tar.gz ????-heimdal-7.4.0-*.patch /root/

RUN apk add --no-cache libc-dev \
                       ncurses-dev \
                       patch && \
    cd ~ && \
    tar -xvf 'heimdal-7.4.0.tar.gz' && \
    cd 'heimdal-7.4.0' && \
    for patch in $(ls -1 ~/????-heimdal-7.4.0-*.patch | sort); do \
      patch -p1 < "${patch}"; \
    done && \
    ./configure --prefix=/opt/heimdal \
                --without-otp && \
    make CFLAGS='-Wno-cpp'

CMD ["/usr/bin/env", "bash"]
