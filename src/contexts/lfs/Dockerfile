ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

WORKDIR /root

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 /root/buildscripts/
RUN buildscripts/build linux-headers-4.12.7 /usr/src/linux-4.12.7.tar.xz

ENV     HOME=/root
WORKDIR "$HOME"
SHELL   ["/bin/bash", "-c"]
CMD     ["/bin/bash", "--login"]
