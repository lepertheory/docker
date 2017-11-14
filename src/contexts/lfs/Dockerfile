ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

# FIXME: Actually calculate the SBUs.
RUN echo 1.0 > "$HOME"/total_sbus

# FIXME: Take this out, see the problem, fix it the right way.
RUN mkdir --parents "$HOME"/build

# FIXME: Same, take out, fix by DRYing upstream.
ENV SOURCES=/usr/src

COPY buildscripts/build buildscripts/common /root/buildscripts/

# FIXME: Comment somewhere better this idea: Tag images with an order-
#        independent hash of the dependencies installed. That way you:
#        1. Get all of your deps installed in a completely-uncustomized (as
#           much as possible while still being part of the framework) baseline
#           image that's automatically shared without needing to manually build
#           a shared docker image.
#        2. All configuration is done by your script. You can call out to other
#           services to generate Dockerfiles.

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 /root/buildscripts/
RUN  buildscripts/build prepare linux-4.12.7.tar.xz
RUN  buildscripts/build linux-headers-4.12.7

#
# FROM: :LFS
# REF: Chapter6.8
#
COPY buildscripts/man-pages-4.12 /root/buildscripts/
RUN  buildscripts/build prepare man-pages-4.12.tar.xz
RUN  buildscripts/build man-pages-4.12

#
# FROM: :LFS
# REF: Chapter6.9
#
COPY glibc-2.26-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/glibc-2.26* /root/buildscripts/
RUN  buildscripts/build prepare glibc-2.26.tar.xz
RUN  buildscripts/build glibc-2.26 01-patch
RUN  buildscripts/build glibc-2.26 02-prepare-lfs
RUN  buildscripts/build glibc-2.26 03-configure
RUN  buildscripts/build glibc-2.26 04-make end

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login"]
