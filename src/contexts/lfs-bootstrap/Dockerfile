ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-host-toolchain:$GIT_BRANCH AS staging

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
ENV LFS="$LFS"
ENV BUILD="$LFS"/build \
    SOURCES="$LFS"/usr/src

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
RUN mkdir -v      "$LFS"     \
 && mkdir -v      "$BUILD"   \
 && mkdir -vp     "$SOURCES" \
 && chmod -v a+wt "$SOURCES"

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
RUN mkdir -v "$LFS"/tools
RUN ln -sv "$LFS"/tools /

#
# FROM: :LFS
# REF: Chapter4.3
#
RUN groupadd lfs \
 && useradd --shell=/bin/bash --gid=lfs --create-home --skel=/dev/null lfs
RUN chown -v lfs:lfs "$LFS"/{build,tools}
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
COPY buildscripts/build buildscripts/common ./buildscripts/
COPY sources/* "$SOURCES"/

#
# FROM: :LFS
# REF: Chapter5.4
#
COPY buildscripts/binutils-2.29 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build binutils-2.29 "$SOURCES"/binutils-2.29.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.5
#
COPY buildscripts/gcc-7.2.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build gcc-7.2.0 "$SOURCES"/gcc-7.2.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.6
#
COPY buildscripts/linux-headers-4.12.7 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build linux-headers-4.12.7 "$SOURCES"/linux-4.12.7.tar.xz

#
# FROM: :LFS
# REF: Chapter5.7
#
COPY buildscripts/glibc-2.26 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build glibc-2.26 "$SOURCES"/glibc-2.26.tar.xz

#
# FROM: :LFS
# REF: Chapter5.8
#
COPY buildscripts/libstdc++-7.2.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build libstdc++-7.2.0 "$SOURCES"/gcc-7.2.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.9
#
COPY buildscripts/binutils-2.29-pass2 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build binutils-2.29-pass2 "$SOURCES"/binutils-2.29.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.10
#
COPY buildscripts/gcc-7.2.0-pass2 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build gcc-7.2.0-pass2 "$SOURCES"/gcc-7.2.0.tar.xz

# FROM: Chapter5.10
#
# LFS_TGT is no longer referenced after this point.
# FIXME: x86_64 stuff.
RUN rm -rfv "$LFS"/tools/bin/x86_64-lfs-*                 \
            "$LFS"/tools/lib/gcc/x86_64-lfs-linux-gnu     \
            "$LFS"/tools/libexec/gcc/x86_64-lfs-linux-gnu \
            "$LFS"/tools/x86_64-lfs-linux-gnu

#
# FROM: :LFS
# REF: Chapter5.11
#
COPY buildscripts/tcl-core-8.6.7 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build tcl-core-8.6.7 "$SOURCES"/tcl-core8.6.7-src.tar.gz

#
# FROM: :LFS
# REF: Chapter5.12
#
COPY buildscripts/expect-5.45 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build expect-5.45 "$SOURCES"/expect5.45.tar.gz

#
# FROM: :LFS
# REF: Chapter5.13
#
COPY buildscripts/dejagnu-1.6 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build dejagnu-1.6 "$SOURCES"/dejagnu-1.6.tar.gz

#
# FROM: :LFS
# REF: Chapter5.14
#
COPY buildscripts/check-0.11.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build check-0.11.0 "$SOURCES"/check-0.11.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.15
#
COPY buildscripts/ncurses-6.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build ncurses-6.0 "$SOURCES"/ncurses-6.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.16
#
COPY buildscripts/bash-4.4 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build bash-4.4 "$SOURCES"/bash-4.4.tar.gz

#
# FROM: :LFS
# REF: Chapter5.17
#
COPY buildscripts/bison-3.0.4 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build bison-3.0.4 "$SOURCES"/bison-3.0.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.18
#
COPY buildscripts/bzip2-1.0.6 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build bzip2-1.0.6 "$SOURCES"/bzip2-1.0.6.tar.gz

#
# FROM: :LFS
# REF: Chapter5.19
#
COPY buildscripts/coreutils-8.27 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build coreutils-8.27 "$SOURCES"/coreutils-8.27.tar.xz

#
# FROM: :LFS
# REF: Chapter5.20
#
COPY buildscripts/diffutils-3.6 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build diffutils-3.6 "$SOURCES"/diffutils-3.6.tar.xz

#
# FROM: :LFS
# REF: Chapter5.21
#
COPY buildscripts/file-5.31 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build file-5.31 "$SOURCES"/file-5.31.tar.gz

#
# FROM: :LFS
# REF: Chapter5.22
#
COPY buildscripts/findutils-4.6.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build findutils-4.6.0 "$SOURCES"/findutils-4.6.0.tar.gz

#
# FROM: :LFS
# REF: Chapter5.23
#
COPY buildscripts/gawk-4.1.4 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build gawk-4.1.4 "$SOURCES"/gawk-4.1.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.24
#
COPY buildscripts/gettext-0.19.8.1 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build gettext-0.19.8.1 "$SOURCES"/gettext-0.19.8.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.25
#
COPY buildscripts/grep-3.1 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build grep-3.1 "$SOURCES"/grep-3.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.26
#
COPY buildscripts/gzip-1.8 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build gzip-1.8 "$SOURCES"/gzip-1.8.tar.xz

#
# FROM: :LFS
# REF: Chapter5.27
#
COPY buildscripts/m4-1.4.18 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build m4-1.4.18 "$SOURCES"/m4-1.4.18.tar.xz

#
# FROM: :LFS
# REF: Chapter5.28
#
COPY buildscripts/make-4.2.1 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build make-4.2.1 "$SOURCES"/make-4.2.1.tar.bz2

#
# FROM: :LFS
# REF: Chapter5.29
#
COPY buildscripts/patch-2.7.5 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build patch-2.7.5 "$SOURCES"/patch-2.7.5.tar.xz

#
# FROM: :LFS
# REF: Chapter5.30
#
COPY buildscripts/perl-5.26.0 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build perl-5.26.0 "$SOURCES"/perl-5.26.0.tar.xz

#
# FROM: :LFS
# REF: Chapter5.31
#
COPY buildscripts/sed-4.4 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build sed-4.4 "$SOURCES"/sed-4.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.32
#
COPY buildscripts/tar-1.29 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build tar-1.29 "$SOURCES"/tar-1.29.tar.xz

#
# FROM: :LFS
# REF: Chapter5.33
#
COPY buildscripts/texinfo-6.4 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build texinfo-6.4 "$SOURCES"/texinfo-6.4.tar.xz

#
# FROM: :LFS
# REF: Chapter5.34
#
COPY buildscripts/util-linux-2.30.1 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build util-linux-2.30.1 "$SOURCES"/util-linux-2.30.1.tar.xz

#
# FROM: :LFS
# REF: Chapter5.35
#
COPY buildscripts/xz-5.2.3 ./buildscripts/
RUN . .bashrc \
 && buildscripts/build xz-5.2.3 "$SOURCES"/xz-5.2.3.tar.xz

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

#
# No longer needed stuff.
#
#RUN rm -rf /home/lfs/buildscripts \
#           "${LFS}"/sources
RUN rm -rf "$BUILD" \
 && mkdir -pv /mnt/lfs/root/buildscripts \
 && cp /home/lfs/buildscripts/{build,common} /mnt/lfs/root/buildscripts

#
# FROM: :LFS
# REF: Chapter6.1
#
# Informational only.
#

#
# FROM: :LFS
# REF: Chapter6.2
#
# Docker takes care of this for us.
#

#
# FROM: :LFS
# REF: Chapter6.3
#
# Informational only.
#

#
# FROM: :LFS
# REF: Chapter6.4
# REF: Chapter6.5
# REF: Chapter6.6
#
# FIXME: The chroot is from 6.4.
# NOTE: Also symlinking env into /usr/bin
#
COPY etc/passwd etc/group "${LFS}"/etc/
RUN chroot "${LFS}" /tools/bin/env --ignore-environment                          \
                                   HOME=/root                                    \
                                   TERM="${TERM}"                                \
                                   PS1='\u:\w\$ '                                \
                                   PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
                                   /tools/bin/bash --login +h -c '               \
    mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}          \
 && mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}                               \
 && install --directory --verbose --mode=0750 /root                              \
 && install --directory --verbose --mode=1777 /tmp /var/tmp                      \
 && mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}                           \
 && mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}               \
 && mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}                       \
 && mkdir -v  /usr/libexec                                                       \
 && mkdir -pv /usr/{,local/}share/man/man{1..8}                                  \
 && if [[ "$(uname -m)" == 'x86_64' ]]; then                                     \
      mkdir -v /lib64                                                            \
  ; fi                                                                           \
 && mkdir -v /var/{log,mail,spool}                                               \
 && ln -sv /run /var/run                                                         \
 && ln -sv /run/lock /var/lock                                                   \
 && mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}                     \
 && ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin                     \
 && ln -sv /tools/bin/{install,perl,env}                /usr/bin                 \
 && ln -sv /tools/lib/libgcc_s.so{,.1}                  /usr/lib                 \
 && ln -sv /tools/lib/libstdc++.{a,so{,.6}}             /usr/lib                 \
 && sed 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la           \
 && for lib in blkid lzma mount uuid; do                                         \
      ln -sv /tools/lib/lib"${lib}".{a,so*}             /usr/lib                 \
 &&   sed 's/tools/usr/' /tools/lib/lib"${lib}".la > /usr/lib/lib"${lib}".la     \
  ; done                                                                         \
 && ln -sv bash /bin/sh                                                          \
 && touch /var/log/{btmp,lastlog,faillog,wtmp}                                   \
 && chgrp -v utmp /var/log/lastlog                                               \
 && chmod -v 644  /var/log/lastlog                                               \
 && chmod -v 600  /var/log/btmp'
COPY root_home/* "$LFS"/root/

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login", "+h"]

#
# Outside of the book, squash image down to size.
#
FROM scratch
COPY --from=staging /mnt/lfs /

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login", "+h"]
