ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

# FIXME: Actually calculate the SBUs.
RUN echo 1.0 > "$HOME"/total_sbus

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 /root/buildscripts/
RUN  buildscripts/build linux-headers-4.12.7 /usr/src/linux-4.12.7.tar.xz

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login"]
