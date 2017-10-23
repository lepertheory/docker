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
RUN mkdir -v      "${LFS}"         \
 && mkdir -v      "${LFS}"/sources \
 && chmod -v a+wt "${LFS}"/sources

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
COPY sources/binutils-2.29.tar.bz2 "${LFS}"/sources/
COPY buildscripts/binutils-2.29 ./buildscripts/
RUN . .bashrc && buildscripts/build binutils-2.29 binutils-2.29.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.5
#
COPY sources/gcc-7.2.0.tar.xz  \
     sources/mpfr-3.1.5.tar.xz \
     sources/gmp-6.1.2.tar.xz  \
     sources/mpc-1.0.3.tar.gz  "${LFS}"/sources/
COPY buildscripts/gcc-7.2.0 ./buildscripts/
RUN . .bashrc && buildscripts/build gcc-7.2.0 gcc-7.2.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.6
#
COPY sources/linux-4.12.7.tar.xz "${LFS}"/sources/
COPY buildscripts/linux-headers-4.12.7 ./buildscripts/
RUN . .bashrc && buildscripts/build linux-headers-4.12.7 linux-4.12.7.tar.xz

#
# FROM: :LFS
# REF: Chapter5.7
#
COPY sources/glibc-2.26.tar.xz "${LFS}"/sources/
COPY buildscripts/glibc-2.26 ./buildscripts/
RUN . .bashrc && buildscripts/build glibc-2.26 glibc-2.26.tar.xz

#
# FROM: :LFS
# REF: Chapter5.8
#
COPY buildscripts/libstdc++-7.2.0 ./buildscripts/
RUN . .bashrc && buildscripts/build libstdc++-7.2.0 gcc-7.2.0.tar.xz
