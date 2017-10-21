FROM lfs/bootstrap/ubuntu:master AS with-debs

WORKDIR /root/apt-offline-bootstrap
COPY apt-offline-bootstrap/* /root/apt-offline-bootstrap/

RUN dpkg --install libpython2.7-minimal_2.7.12-1ubuntu0~16.04.1_amd64.deb \
 && dpkg --install python2.7-minimal_2.7.12-1ubuntu0~16.04.1_amd64.deb    \
 && dpkg --install mime-support_3.59ubuntu1_all.deb                       \
 && dpkg --install libexpat1_2.1.0-7ubuntu0.16.04.3_amd64.deb             \
 && dpkg --install libffi6_3.2.1-4_amd64.deb                              \
 && dpkg --install libsqlite3-0_3.11.0-1ubuntu1_amd64.deb                 \
 && dpkg --install libssl1.0.0_1.0.2g-1ubuntu4.8_amd64.deb                \
 && dpkg --install libpython2.7-stdlib_2.7.12-1ubuntu0~16.04.1_amd64.deb  \
 && dpkg --install python-minimal_2.7.11-1_amd64.deb                      \
 && dpkg --install libpython-stdlib_2.7.11-1_amd64.deb                    \
 && dpkg --install python2.7_2.7.12-1ubuntu0~16.04.1_amd64.deb            \
 && dpkg --install python_2.7.11-1_amd64.deb                              \
 && dpkg --install less_481-2.1ubuntu0.2_amd64.deb                        \
 && dpkg --install libmagic1_1%3a5.25-2ubuntu1_amd64.deb                  \
 && dpkg --install python-magic_1%3a5.25-2ubuntu1_all.deb                 \
 && dpkg --install apt-offline_1.7_all.deb                                \
                                                                          \
 && mkdir -p /var/lib/apt/lists/partial                                   \
                                                                          \
 && cd /root                                                              \
 && rm -rf /root/apt-offline-bootstrap

WORKDIR /root



FROM scratch

COPY --from=with-debs / /
