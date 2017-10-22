FROM lfs/bootstrap/host-toolchain:master

#
# REF: Chapter 2.3
# REF: Chapter 2.4
# REF: Chapter 2.5
#
# These are unnecessary when building on Docker.
#

#
# REF: Chapter 2.6
#
ARG LFS=/mnt/lfs

#
# REF: Chapter 2.7 
#
# Not needed when building on Docker.
#

#
# REF: Chapter 3.1
#
COPY sources/* "${LFS}"/sources/
RUN chmod -v a+wt "${LFS}"/sources

#
# REF: Chapter 3.2
# REF: Chapter 3.3
#
# Only necessary when upgrading the book, or there are patches. If you update, leave the files in
# the ${SCRIPT_PATH}/../sources directory.
#

#
# REF: Chapter 4.1
#
# Just an intro.
#

#
# REF: Chapter 4.2
#
RUN mkdir -v "${LFS}"/tools
RUN ln -sv "${LFS}"/tools /

#
# REF: Chapter 4.3
#
RUN groupadd lfs \
 && useradd --shell=/bin/bash --gid=lfs --create-home --skel=/dev/null lfs
RUN chown -v lfs:lfs "${LFS}"/{tools,sources}
USER lfs:lfs
WORKDIR /home/lfs

#
# REF: Chapter 4.4
#
COPY lfs_home/* ./

#
# REF: Chapter 4.5
# REF: Chapter 4.6
# REF: Chapter 5.1
# REF: Chapter 5.2
# REF: Chapter 5.3
#
# Informational only.
#
COPY buildscripts/build ./buildscripts/

#
# REF: Chapter 5.4
#
COPY buildscripts/binutils-2.29 ./buildscripts/
RUN buildscripts/build "${LFS}" "${LFS_TGT}" binutils-2.29 binutils-2.29.tar.bz2

#
# REF: Chapter 5.5
#
COPY buildscripts/gcc-7.2.0 ./buildscripts/
RUN buildscripts/build "${LFS}" "${LFS_TGT}" gcc-7.2.0 gcc-7.2.0.tar.xz

#
# REF: Chapter 5.6
#
COPY buildscripts/linux-headers-4.12.7 ./buildscripts/
RUN buildscripts/build "${LFS}" "${LFS_TGT}" linux-headers-4.12.7 linux-4.12.7.tar.xz linux-4.12.7
