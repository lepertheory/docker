FROM lfs/bootstrap/host-toolchain:master

#
# FROM: :LFS
# REF: Chapter2.3
# REF: Chapter2.4
# REF: Chapter2.5
#
# These are unnecessary when building on Docker.
#

#
# FROM: :LFS
# REF: Chapter2.6
#
ARG LFS=/mnt/lfs
ENV LFS="${LFS}"

#
# FROM: :LFS
# REF: Chapter2.7
#
# Not needed when building on Docker.
#

#
# FROM: :LFS
# REF: Chapter3.1
#
COPY sources/* "${LFS}"/sources/
RUN chmod -v a+wt "${LFS}"/sources

#
# FROM: :LFS
# REF: Chapter3.2
# REF: Chapter3.3
#
# Only necessary when upgrading the book, or there are patches. If you update, leave the files in
# the ${SCRIPT_PATH}/../sources directory.
#

#
# FROM: :LFS
# REF: Chapter4.1
#
# Just an intro.
#

#
# FROM: :LFS
# REF: Chapter4.2
#
RUN mkdir -v "${LFS}"/tools
RUN ln -sv "${LFS}"/tools /

#
# FROM: :LFS
# REF: Chapter4.3
#
RUN groupadd lfs \
 && useradd --shell=/bin/bash --gid=lfs --create-home --skel=/dev/null lfs
RUN chown -v lfs:lfs "${LFS}"/{tools,sources}
USER lfs:lfs
WORKDIR /home/lfs

#
# FROM: :LFS
# REF: Chapter4.4
#
COPY lfs_home/* ./

#
# FROM: :LFS
# REF: Chapter4.5
# REF: Chapter4.6
# REF: Chapter5.1
# REF: Chapter5.2
# REF: Chapter5.3
#
# Informational only.
#
COPY buildscripts/build ./buildscripts/

#
# FROM: :LFS
# REF: Chapter5.4
#
COPY buildscripts/binutils-2.29 ./buildscripts/
RUN buildscripts/build binutils-2.29 binutils-2.29.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.5
#
COPY buildscripts/gcc-7.2.0 ./buildscripts/
RUN buildscripts/build gcc-7.2.0 gcc-7.2.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.6
#
COPY buildscripts/linux-headers-4.12.7 ./buildscripts/
RUN buildscripts/build linux-headers-4.12.7 linux-4.12.7.tar.xz linux-4.12.7
