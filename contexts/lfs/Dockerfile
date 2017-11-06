ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

COPY buildscripts/build buildscripts/common ./buildscripts/

#
# FROM: :LFS
# REF: Chapter6.7
#
COPY buildscripts/linux-headers-4.12.7 /root/buildscripts/
RUN buildscripts/build linux-he
