ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 buildscripts/
RUN  buildscripts/build linux-headers-4.12.7 prepare linux-4.12.7.tar.xz
RUN  buildscripts/build linux-headers-4.12.7

#
# FROM: :LFS
# REF: Chapter6.8
#
COPY buildscripts/man-pages-4.12 buildscripts/
RUN  buildscripts/build man-pages-4.12 prepare man-pages-4.12.tar.xz
RUN  buildscripts/build man-pages-4.12

#
# FROM: :LFS
# REF: Chapter6.9
#
COPY glibc-2.26-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/glibc-2.26 buildscripts/
RUN  buildscripts/build glibc-2.26 prepare glibc-2.26.tar.xz
COPY buildscripts/glibc-2.26-01-patch buildscripts/
RUN  buildscripts/build glibc-2.26 01-patch
COPY buildscripts/glibc-2.26-02-prepare-lfs buildscripts/
RUN  buildscripts/build glibc-2.26 02-prepare-lfs
COPY buildscripts/glibc-2.26-03-configure buildscripts/
RUN  buildscripts/build glibc-2.26 03-configure
COPY buildscripts/glibc-2.26-04-make buildscripts/
RUN  buildscripts/build glibc-2.26 04-make
COPY buildscripts/glibc-2.26-05-test buildscripts/
RUN  buildscripts/build glibc-2.26 05-test
COPY buildscripts/glibc-2.26-06-install buildscripts/
RUN  buildscripts/build glibc-2.26 06-install

# FROM scratch
# COPY --from=staging / /
#
# ENV     HOME=/root
# WORKDIR "$HOME"
# SHELL   ["/bin/bash", "--login", "-c"]
# CMD     ["/bin/bash", "--login"]

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login"]
