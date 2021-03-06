ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/ubuntu-core:$GIT_BRANCH AS staging

ARG APT_OFFLINE=/root/apt-offline
ENV APT_OFFLINE="$APT_OFFLINE"

WORKDIR "$APT_OFFLINE"
COPY *.deb ./

RUN dpkg --install libpython2.7-minimal_2.7.12-1ubuntu0~16.04.1_amd64.deb
RUN dpkg --install python2.7-minimal_2.7.12-1ubuntu0~16.04.1_amd64.deb
RUN dpkg --install mime-support_3.59ubuntu1_all.deb
RUN dpkg --install libexpat1_2.1.0-7ubuntu0.16.04.3_amd64.deb
RUN dpkg --install libffi6_3.2.1-4_amd64.deb
RUN dpkg --install libsqlite3-0_3.11.0-1ubuntu1_amd64.deb
RUN dpkg --install libssl1.0.0_1.0.2g-1ubuntu4.8_amd64.deb
RUN dpkg --install libpython2.7-stdlib_2.7.12-1ubuntu0~16.04.1_amd64.deb
RUN dpkg --install python-minimal_2.7.11-1_amd64.deb
RUN dpkg --install libpython-stdlib_2.7.11-1_amd64.deb
RUN dpkg --install python2.7_2.7.12-1ubuntu0~16.04.1_amd64.deb
RUN dpkg --install python_2.7.11-1_amd64.deb
RUN dpkg --install less_481-2.1ubuntu0.2_amd64.deb
RUN dpkg --install libmagic1_1%3a5.25-2ubuntu1_amd64.deb
RUN dpkg --install python-magic_1%3a5.25-2ubuntu1_all.deb
RUN dpkg --install apt-offline_1.7_all.deb
RUN rm *.deb
RUN mkdir -p /var/lib/apt/lists/partial

COPY apt-offline/* "$APT_OFFLINE"/

FROM scratch
COPY --from=staging / /

ENV     HOME=/root
WORKDIR "$HOME"
SHELL   ["/bin/bash", "--login", "-c"]
CMD     ["/bin/bash", "--login"]]

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login"]

ONBUILD ARG     APT_OFFLINE="$HOME"/apt-offline
ONBUILD ENV     APT_OFFLINE="$APT_OFFLINE"
ONBUILD COPY    apt-offline/* "$APT_OFFLINE"/
ONBUILD RUN     "$APT_OFFLINE"/install
