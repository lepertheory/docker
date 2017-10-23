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
# REF: Chapter4.5
#
COPY lfs_home/* ./

# FROM: :LFS
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

#
# FROM: :LFS
# REF: Chapter5.9
#
COPY buildscripts/binutils-2.29-pass2 ./buildscripts/
RUN . .bashrc && buildscripts/build binutils-2.29-pass2 binutils-2.29.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.10
#
COPY buildscripts/gcc-7.2.0-pass2 ./buildscripts/
RUN . .bashrc && buildscripts/build gcc-7.2.0-pass2 gcc-7.2.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.11
#
COPY sources/tcl-core8.6.7-src.tar.gz "${LFS}"/sources/
COPY buildscripts/tcl-core-8.6.7 ./buildscripts/
RUN . .bashrc && buildscripts/build tcl-core-8.6.7 tcl-core8.6.7-src.tar.gz

#
# FROM: :LFS
# REF: Chapter5.12
#
COPY sources/expect5.45.tar.gz "${LFS}"/sources/
COPY buildscripts/expect-5.45 ./buildscripts/
RUN . .bashrc && buildscripts/build expect-5.45 expect5.45.tar.gz

#
# FROM: :LFS
# REF: Chapter5.13
#
COPY sources/dejagnu-1.6.tar.gz "${LFS}"/sources/
COPY buildscripts/dejagnu-1.6 ./buildscripts/
RUN . .bashrc && buildscripts/build dejagnu-1.6 dejagnu-1.6.tar.gz

#
# FROM: :LFS
# REF: Chapter5.14
#
COPY sources/check-0.11.0.tar.gz "${LFS}"/sources/
COPY buildscripts/check-0.11.0 ./buildscripts/
RUN . .bashrc && buildscripts/build check-0.11.0 check-0.11.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.15
#
COPY sources/ncurses-6.0.tar.gz "${LFS}"/sources/
COPY buildscripts/ncurses-6.0 ./buildscripts/
RUN . .bashrc && buildscripts/build ncurses-6.0 ncurses-6.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.16
#
COPY sources/bash-4.4.tar.gz "${LFS}"/sources/
COPY buildscripts/bash-4.4 ./buildscripts/
RUN . .bashrc && buildscripts/build bash-4.4 bash-4.4.tar.gz

#
# FROM: :LFS
# REF: Chapter5.17
#
COPY sources/bison-3.0.4.tar.xz "${LFS}"/sources/
COPY buildscripts/bison-3.0.4 ./buildscripts/
RUN . .bashrc && buildscripts/build bison-3.0.4 bison-3.0.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.18
#
COPY sources/bzip2-1.0.6.tar.gz "${LFS}"/sources/
COPY buildscripts/bzip2-1.0.6 ./buildscripts/
RUN . .bashrc && buildscripts/build bzip2-1.0.6 bzip2-1.0.6.tar.gz

#
# FROM: :LFS
# REF: Chapter5.19
#
COPY sources/coreutils-8.27.tar.xz "${LFS}"/sources/
COPY buildscripts/coreutils-8.27 ./buildscripts/
RUN . .bashrc && buildscripts/build coreutils-8.27 coreutils-8.27.tar.xz

#
# FROM: :LFS
# REF: Chapter5.20
#
COPY sources/diffutils-3.6.tar.xz "${LFS}"/sources/
COPY buildscripts/diffutils-3.6 ./buildscripts/
RUN . .bashrc && buildscripts/build diffutils-3.6 diffutils-3.6.tar.xz

#
# FROM: :LFS
# REF: Chapter5.21
#
COPY sources/file-5.31.tar.gz "${LFS}"/sources/
COPY buildscripts/file-5.31 ./buildscripts/
RUN . .bashrc && buildscripts/build file-5.31 file-5.31.tar.gz

#
# FROM: :LFS
# REF: Chapter5.22
#
COPY sources/findutils-4.6.0.tar.gz "${LFS}"/sources/
COPY buildscripts/findutils-4.6.0 ./buildscripts/
RUN . .bashrc && buildscripts/build findutils-4.6.0 findutils-4.6.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.23
#
COPY sources/gawk-4.1.4.tar.xz "${LFS}"/sources/
COPY buildscripts/gawk-4.1.4 ./buildscripts/
RUN . .bashrc && buildscripts/build gawk-4.1.4 gawk-4.1.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.24
#
COPY sources/gettext-0.19.8.1.tar.xz "${LFS}"/sources/
COPY buildscripts/gettext-0.19.8.1 ./buildscripts/
RUN . .bashrc && buildscripts/build gettext-0.19.8.1 gettext-0.19.8.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.25
#
COPY sources/grep-3.1.tar.xz "${LFS}"/sources/
COPY buildscripts/grep-3.1 ./buildscripts/
RUN . .bashrc && buildscripts/build grep-3.1 grep-3.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.26
#
COPY sources/gzip-1.8.tar.xz "${LFS}"/sources/
COPY buildscripts/gzip-1.8 ./buildscripts/
RUN . .bashrc && buildscripts/build gzip-1.8 gzip-1.8.tar.xz

#
# FROM: :LFS
# REF: Chapter5.27
#
COPY sources/m4-1.4.18.tar.xz "${LFS}"/sources/
COPY buildscripts/m4-1.4.18 ./buildscripts/
RUN . .bashrc && buildscripts/build m4-1.4.18 m4-1.4.18.tar.xz

#
# FROM: :LFS
# REF: Chapter5.28
#
COPY sources/make-4.2.1.tar.bz2 "${LFS}"/sources/
COPY buildscripts/make-4.2.1 ./buildscripts/
RUN . .bashrc && buildscripts/build make-4.2.1 make-4.2.1.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.29
#
COPY sources/patch-2.7.5.tar.xz "${LFS}"/sources/
COPY buildscripts/patch-2.7.5 ./buildscripts/
RUN . .bashrc && buildscripts/build patch-2.7.5 patch-2.7.5.tar.xz

#
# FROM: :LFS
# REF: Chapter5.30
#
COPY sources/perl-5.26.0.tar.xz "${LFS}"/sources/
COPY buildscripts/perl-5.26.0 ./buildscripts/
RUN . .bashrc && buildscripts/build perl-5.26.0 perl-5.26.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.31
#
COPY sources/sed-4.4.tar.xz "${LFS}"/sources/
COPY buildscripts/sed-4.4 ./buildscripts/
RUN . .bashrc && buildscripts/build sed-4.4 sed-4.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.32
#
COPY sources/tar-1.29.tar.xz "${LFS}"/sources/
COPY buildscripts/tar-1.29 ./buildscripts/
RUN . .bashrc && buildscripts/build tar-1.29 tar-1.29.tar.xz

#
# FROM: :LFS
# REF: Chapter5.33
#
COPY sources/texinfo-6.4.tar.xz "${LFS}"/sources/
COPY buildscripts/texinfo-6.4 ./buildscripts/
RUN . .bashrc && buildscripts/build texinfo-6.4 texinfo-6.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.34
#
COPY sources/util-linux-2.30.1.tar.xz "${LFS}"/sources/
COPY buildscripts/util-linux-2.30.1 ./buildscripts/
RUN . .bashrc && buildscripts/build util-linux-2.30.1 util-linux-2.30.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.35
#
COPY sources/xz-5.2.3.tar.xz "${LFS}"/sources/
COPY buildscripts/xz-5.2.3 ./buildscripts/
RUN . .bashrc && buildscripts/build xz-5.2.3 xz-5.2.3.tar.xz

#
# FROM: :LFS
# REF: Chapter5.36
#
RUN strip --strip-debug /tools/lib/*                 \
  ; /usr/bin/strip --strip-unneeded /tools/{,s}bin/* \
  ; rm -rf /tools/{,share}/{info,man,doc}

#
# FROM: :LFS
# REF: Chapter5.37
#
USER root
RUN chown -R root:root "${LFS}"/tools
