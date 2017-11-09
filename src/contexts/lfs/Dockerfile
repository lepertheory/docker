ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 /root/buildscripts/
RUN . .bash_profile \
 && buildscripts/build linux-headers-4.12.7 /usr/src/linux-4.12.7.tar.xz
