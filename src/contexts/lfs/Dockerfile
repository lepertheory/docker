ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH AS stage1

ENV SOURCES=/usr/src
RUN mkdir build

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
COPY buildscripts/glibc-2.26-07-config-nsswitch buildscripts/
RUN  buildscripts/build glibc-2.26 07-config-nsswitch
COPY buildscripts/glibc-2.26-08-config-tzdata buildscripts/
RUN  buildscripts/build glibc-2.26 08-config-tzdata
COPY buildscripts/glibc-2.26-09-config-dl buildscripts/
RUN  buildscripts/build glibc-2.26 09-config-dl

#
# FROM: :LFS
# REF: Chapter6.10
#

# Swap ld
RUN MACHINE="$(uname --machine)"        \
  ; TARGET="$MACHINE"-pc-linux-gnu      \
  ; mv /tools/bin/{ld,ld-old}           \
 && mv /tools/"$TARGET"/bin/{ld,ld-old} \
 && mv /tools/bin/{ld-new,ld}           \
 && ln --symbolic /tools/bin/ld /tools/"$TARGET"/bin/ld

# Point GCC to the correct headers and start files.
RUN gcc -dumpspecs | sed --expression='s@/tools@@g'                                    \
                         --expression='/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
                         --expression='/\*cpp:/{n;s@$@ -isystem /usr/include@}'        \
    > "$(dirname "$(gcc --print-libgcc-file-name)")"/specs

# A minimal (and invalid!) test.
RUN echo 'int main(){}' > dummy.c \
 && cc --verbose -Wl,--verbose --output=dummy dummy.c &> dummy.log

# More validation.
RUN readelf --program-headers dummy | grep --quiet ': /lib'
RUN [[ "$(grep '^attempt to open /usr/lib/crt[1in]\.o succeeded$' dummy.log | wc --lines)" == 3 ]]
RUN [[ "$(grep --before=1 '^ /usr/include$' dummy.log | head -n1)" \
       == "#include <...> search starts here:" ]]
RUN [[ "$(grep 'SEARCH.*/usr/lib' dummy.log                                  \
          | sed 's/; /\n/g'                                                  \
          | grep --invert-match -- -linux-gnu                                \
          | sed --regexp-extended --quiet 's/^SEARCH_DIR\(\"(.*)\"\)/\1/p')" \
       == $'/usr/lib\n/lib' ]]
RUN grep --quiet                                    \
         --fixed-strings                            \
         'attempt to open /lib/libc.so.6 succeeded' \
         dummy.log
RUN grep --quiet                                                   \
         --fixed-strings                                           \
         'found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2' \
         dummy.log
RUN rm dummy{,.{c,log}}

#
# FROM: :LFS
# REF: Chapter6.11
#
COPY buildscripts/zlib-1.2.11 buildscripts/
RUN  buildscripts/build zlib-1.2.11 prepare zlib-1.2.11.tar.xz
RUN  buildscripts/build zlib-1.2.11

#
# FROM: :LFS
# REF: Chapter6.12
#
COPY buildscripts/file-5.31 buildscripts/
RUN  buildscripts/build file-5.31 prepare file-5.31.tar.gz
RUN  buildscripts/build file-5.31

#
# FROM: :LFS
# REF: Chapter6.13
#
COPY buildscripts/readline-7.0 buildscripts/
RUN  buildscripts/build readline-7.0 prepare readline-7.0.tar.gz
RUN  buildscripts/build readline-7.0

#
# FROM: :LFS
# REF: Chapter6.14
#
COPY buildscripts/m4-1.4.18 buildscripts/
RUN  buildscripts/build m4-1.4.18 prepare m4-1.4.18.tar.xz
RUN  buildscripts/build m4-1.4.18

#
# FROM: :LFS
# REF: Chapter6.15
#
COPY buildscripts/bc-1.07.1 buildscripts/
RUN  buildscripts/build bc-1.07.1 prepare bc-1.07.1.tar.gz
RUN  buildscripts/build bc-1.07.1

#
# FROM: :LFS
# REF: Chapter6.16
#
RUN  buildscripts/build binutils-2.29 prepare binutils-2.29.tar.bz2
COPY buildscripts/binutils-2.29 \
     buildscripts/binutils-2.29-01-build buildscripts/
COPY binutils-2.29-disable-broken-tests.patch ./
RUN  buildscripts/build binutils-2.29 01-build
COPY buildscripts/binutils-2.29-02-install buildscripts/
RUN  buildscripts/build binutils-2.29 02-install

#
# FROM: :LFS
# REF: Chapter6.17
#
RUN  buildscripts/build gmp-6.1.2 prepare gmp-6.1.2.tar.xz
COPY buildscripts/gmp-6.1.2 buildscripts/
RUN  buildscripts/build gmp-6.1.2

#
# FROM: :LFS
# REF: Chapter6.18
#
RUN  buildscripts/build mpfr-3.1.5 prepare mpfr-3.1.5.tar.xz
COPY buildscripts/mpfr-3.1.5 buildscripts/
RUN  buildscripts/build mpfr-3.1.5

#
# FROM: :LFS
# REF: Chapter6.19
#
RUN  buildscripts/build mpc-1.0.3 prepare mpc-1.0.3.tar.gz
COPY buildscripts/mpc-1.0.3 buildscripts/
RUN  buildscripts/build mpc-1.0.3

#
# FROM: :LFS
# REF: Chapter6.20
#
RUN  buildscripts/build gcc-7.2.0 prepare gcc-7.2.0.tar.xz
COPY buildscripts/gcc-7.2.0 \
     buildscripts/gcc-7.2.0-01-configure buildscripts/
RUN  buildscripts/build gcc-7.2.0 01-configure
COPY buildscripts/gcc-7.2.0-02-build buildscripts/
RUN  buildscripts/build gcc-7.2.0 02-build
COPY buildscripts/gcc-7.2.0-03-test buildscripts/
RUN  buildscripts/build gcc-7.2.0 03-test
COPY buildscripts/gcc-7.2.0-04-check-test-results buildscripts/
RUN  buildscripts/build gcc-7.2.0 04-check-test-results
COPY buildscripts/gcc-7.2.0-05-install buildscripts/
RUN  buildscripts/build gcc-7.2.0 05-install

#
# FROM: :LFS
# REF: Chapter6.21
#
RUN  buildscripts/build bzip2-1.0.6 prepare bzip2-1.0.6.tar.gz
COPY buildscripts/bzip2-1.0.6 buildscripts/
RUN  buildscripts/build bzip2-1.0.6

#
# FROM: :LFS
# REF: Chapter6.22
#
RUN  buildscripts/build pkg-config-0.29.2 prepare pkg-config-0.29.2.tar.gz
COPY buildscripts/pkg-config-0.29.2 buildscripts/
RUN  buildscripts/build pkg-config-0.29.2

#
# FROM: :LFS
# REF: Chapter6.23
#
RUN  buildscripts/build ncurses-6.0 prepare ncurses-6.0.tar.gz
COPY buildscripts/ncurses-6.0 buildscripts/
RUN  buildscripts/build ncurses-6.0

#
# FROM: :LFS
# REF: Chapter6.24
#
RUN  buildscripts/build attr-2.4.47 prepare attr-2.4.47.src.tar.gz
COPY attr-2.4.47-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/attr-2.4.47 buildscripts/
RUN  buildscripts/build attr-2.4.47

#
# FROM: :LFS
# REF: Chapter6.25
#
RUN  buildscripts/build acl-2.2.52 prepare acl-2.2.52.src.tar.gz
COPY buildscripts/acl-2.2.52 buildscripts/
RUN  buildscripts/build acl-2.2.52

#
# FROM: :LFS
# REF: Chapter6.26
#
RUN  buildscripts/build libcap-2.25 prepare libcap-2.25.tar.xz
COPY buildscripts/libcap-2.25 buildscripts/
RUN  buildscripts/build libcap-2.25

#
# FROM: :LFS
# REF: Chapter6.27
#
RUN  buildscripts/build sed-4.4 prepare sed-4.4.tar.xz
COPY buildscripts/sed-4.4 buildscripts/
RUN  buildscripts/build sed-4.4

#
# FROM: :LFS
# REF: Chapter6.28
#
RUN  buildscripts/build shadow-4.5 prepare shadow-4.5.tar.xz
COPY buildscripts/shadow-4.5 buildscripts/
RUN  buildscripts/build shadow-4.5

#
# FROM: :LFS
# REF: Chapter6.29
#
RUN  buildscripts/build psmisc-23.1 prepare psmisc-23.1.tar.xz
COPY buildscripts/psmisc-23.1 buildscripts/
RUN  buildscripts/build psmisc-23.1

#
# FROM: :LFS
# REF: Chapter6.30
#
RUN  buildscripts/build iana-etc-2.30 prepare iana-etc-2.30.tar.bz2
COPY buildscripts/iana-etc-2.30 buildscripts/
RUN  buildscripts/build iana-etc-2.30

#
# FROM: :LFS
# REF: Chapter6.31
#
RUN  buildscripts/build bison-3.0.4 prepare bison-3.0.4.tar.xz
COPY buildscripts/bison-3.0.4 buildscripts/
RUN  buildscripts/build bison-3.0.4

#
# FROM: :LFS
# REF: Chapter6.32
#
RUN  buildscripts/build flex-2.6.4 prepare flex-2.6.4.tar.gz
COPY buildscripts/flex-2.6.4 buildscripts/
RUN  buildscripts/build flex-2.6.4

#
# FROM: :LFS
# REF: Chapter6.33
#
RUN  buildscripts/build grep-3.1 prepare grep-3.1.tar.xz
COPY buildscripts/grep-3.1 buildscripts/
RUN  buildscripts/build grep-3.1

#
# FROM: :LFS
# REF: Chapter6.34
#
RUN  buildscripts/build bash-4.4 prepare bash-4.4.tar.gz
COPY buildscripts/bash-4.4 buildscripts/
RUN  buildscripts/build bash-4.4

#
# FROM: :LFS
# REF: Chapter6.35
#
RUN  buildscripts/build libtool-2.4.6 prepare libtool-2.4.6.tar.xz
COPY buildscripts/libtool-2.4.6 buildscripts/
RUN  buildscripts/build libtool-2.4.6

#
# FROM: :LFS
# REF: Chapter6.36
#
RUN  buildscripts/build gdbm-1.13 prepare gdbm-1.13.tar.gz
COPY buildscripts/gdbm-1.13 buildscripts/
RUN  buildscripts/build gdbm-1.13

# HACK: Get around too many layers.
FROM scratch AS staging
COPY --from=stage1 / /

ENV     HOME=/root
WORKDIR "$HOME"
SHELL   ["/bin/bash", "--login", "+h", "-c"]
CMD     ["/bin/bash", "--login", "+h"]

# TODO: Get this from the parent layer.
ENV SOURCES=/usr/src

#
# FROM: :LFS
# REF: Chapter6.37
#
RUN  buildscripts/build gperf-3.1 prepare gperf-3.1.tar.gz
COPY buildscripts/gperf-3.1 buildscripts/
RUN  buildscripts/build gperf-3.1

#
# FROM: :LFS
# REF: Chapter6.38
#
RUN  buildscripts/build expat-2.2.3 prepare expat-2.2.3.tar.bz2
COPY buildscripts/expat-2.2.3 buildscripts/
RUN  buildscripts/build expat-2.2.3

#
# FROM: :LFS
# REF: Chapter6.39
#
RUN  buildscripts/build inetutils-1.9.4 prepare inetutils-1.9.4.tar.xz
COPY inetutils-1.9.4-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/inetutils-1.9.4 buildscripts/
RUN  buildscripts/build inetutils-1.9.4

#
# FROM: :LFS
# REF: Chapter6.40
#
RUN  buildscripts/build perl-5.26.0 prepare perl-5.26.0.tar.xz
COPY perl-5.26.0-upstream-docker-fix.patch "$SOURCES"/
COPY buildscripts/perl-5.26.0 \
     buildscripts/perl-5.26.0-01-build buildscripts/
RUN  buildscripts/build perl-5.26.0 01-build
COPY buildscripts/perl-5.26.0-02-install buildscripts/
RUN  buildscripts/build perl-5.26.0 02-install

#
# FROM: :LFS
# REF: Chapter6.41
#
RUN  buildscripts/build xml-parser-2.44 prepare XML-Parser-2.44.tar.gz
COPY buildscripts/xml-parser-2.44 buildscripts/
RUN  buildscripts/build xml-parser-2.44

#
# FROM: :LFS
# REF: Chapter6.42
#
RUN  buildscripts/build intltool-0.51.0 prepare intltool-0.51.0.tar.gz
COPY buildscripts/intltool-0.51.0 buildscripts/
RUN  buildscripts/build intltool-0.51.0

# TODO: Put this in the right place.
RUN echo 'export CPUS="$(nproc --all)"' >> "$HOME"/.bash_profile

#
# FROM: :LFS
# REF: Chapter6.43
#
RUN  buildscripts/build autoconf-2.69 prepare autoconf-2.69.tar.xz
COPY buildscripts/autoconf-2.69 buildscripts/
RUN  buildscripts/build autoconf-2.69

#
# FROM: :LFS
# REF: Chapter6.44
#
RUN  buildscripts/build automake-1.15.1 prepare automake-1.15.1.tar.xz
COPY automake-1.15.1-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/automake-1.15.1 buildscripts/
RUN  buildscripts/build automake-1.15.1

#
# FROM: :LFS
# REF: Chapter6.45
#
RUN  buildscripts/build xz-5.2.3 prepare xz-5.2.3.tar.xz
COPY buildscripts/xz-5.2.3 buildscripts/
RUN  buildscripts/build xz-5.2.3

#
# FROM: :LFS
# REF: Chapter6.46
#
RUN  buildscripts/build kmod-24 prepare kmod-24.tar.xz
COPY buildscripts/kmod-24 buildscripts/
RUN  buildscripts/build kmod-24

#
# FROM: :LFS
# REF: Chapter6.47
#
RUN  buildscripts/build gettext-0.19.8.1 prepare gettext-0.19.8.1.tar.xz
COPY buildscripts/gettext-0.19.8.1 buildscripts/
RUN  buildscripts/build gettext-0.19.8.1

#
# FROM: :LFS
# REF: Chapter6.48
#
RUN  buildscripts/build systemd-234 prepare systemd-234-lfs.tar.xz
COPY buildscripts/systemd-234 buildscripts/
RUN  buildscripts/build systemd-234

#
# FROM: :LFS
# REF: Chapter6.49
#
RUN  buildscripts/build procps-ng-3.3.12 prepare procps-ng-3.3.12.tar.xz
COPY buildscripts/procps-ng-3.3.12 buildscripts/
RUN  buildscripts/build procps-ng-3.3.12

#
# FROM: :LFS
# REF: Chapter6.50
#
RUN  buildscripts/build e2fsprogs-1.43.5 prepare e2fsprogs-1.43.5.tar.gz
COPY buildscripts/e2fsprogs-1.43.5 buildscripts/
RUN  buildscripts/build e2fsprogs-1.43.5

#
# FROM: :LFS
# REF: Chapter6.51
#
RUN  buildscripts/build coreutils-8.27 prepare coreutils-8.27.tar.xz
COPY coreutils-8.27-dunno.patch "$SOURCES"/
COPY buildscripts/coreutils-8.27 buildscripts/
RUN  buildscripts/build coreutils-8.27

#
# FROM: :LFS
# REF: Chapter6.52
#
RUN  buildscripts/build diffutils-3.6 prepare diffutils-3.6.tar.xz
COPY buildscripts/diffutils-3.6 buildscripts/
RUN  buildscripts/build diffutils-3.6

#
# FROM: :LFS
# REF: Chapter6.53
#
RUN  buildscripts/build gawk-4.1.4 prepare gawk-4.1.4.tar.xz
COPY gawk-4.1.4-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/gawk-4.1.4 buildscripts/
RUN  buildscripts/build gawk-4.1.4

#
# FROM: :LFS
# REF: Chapter6.54
#
RUN  buildscripts/build findutils-4.6.0 prepare findutils-4.6.0.tar.gz
COPY buildscripts/findutils-4.6.0 buildscripts/
RUN  buildscripts/build findutils-4.6.0

#
# FROM: :LFS
# REF: Chapter6.55
#
RUN  buildscripts/build groff-1.22.3 prepare groff-1.22.3.tar.gz
COPY buildscripts/groff-1.22.3 buildscripts/
RUN  buildscripts/build groff-1.22.3

#
# FROM: :LFS
# REF: Chapter6.56
#
RUN  buildscripts/build grub-2.02 prepare grub-2.02.tar.xz
COPY buildscripts/grub-2.02 buildscripts/
RUN  buildscripts/build grub-2.02

#
# FROM: :LFS
# REF: Chapter6.57
#
RUN  buildscripts/build less-487 prepare less-487.tar.gz
COPY buildscripts/less-487 buildscripts/
RUN  buildscripts/build less-487

#
# FROM: :LFS
# REF: Chapter6.58
#
RUN  buildscripts/build gzip-1.8 prepare gzip-1.8.tar.xz
COPY gzip-1.8-disable-broken-tests.patch "$SOURCES"/
COPY buildscripts/gzip-1.8 buildscripts/
RUN  buildscripts/build gzip-1.8

#
# FROM: :LFS
# REF: Chapter6.59
#
RUN  buildscripts/build iproute2-4.12.0 prepare iproute2-4.12.0.tar.xz
COPY buildscripts/iproute2-4.12.0 buildscripts/
RUN  buildscripts/build iproute2-4.12.0

#
# FROM: :LFS
# REF: Chapter6.60
#
RUN  buildscripts/build kbd-2.0.4 prepare kbd-2.0.4.tar.xz
COPY buildscripts/kbd-2.0.4 buildscripts/
RUN  buildscripts/build kbd-2.0.4

#
# FROM: :LFS
# REF: Chapter6.61
#
RUN  buildscripts/build libpipeline-1.4.2 prepare libpipeline-1.4.2.tar.gz
COPY buildscripts/libpipeline-1.4.2 buildscripts/
RUN  buildscripts/build libpipeline-1.4.2

#
# FROM: :LFS
# REF: Chapter6.62
#
RUN  buildscripts/build make-4.2.1 prepare make-4.2.1.tar.bz2
COPY buildscripts/make-4.2.1 buildscripts/
RUN  buildscripts/build make-4.2.1

#
# FROM: :LFS
# REF: Chapter6.63
#
RUN  buildscripts/build patch-2.7.5 prepare patch-2.7.5.tar.xz
COPY buildscripts/patch-2.7.5 buildscripts/
RUN  buildscripts/build patch-2.7.5

#
# FROM: :LFS
# REF: Chapter6.64
#
RUN  buildscripts/build dbus-1.10.22 prepare dbus-1.10.22.tar.gz
COPY buildscripts/dbus-1.10.22 buildscripts/
RUN  buildscripts/build dbus-1.10.22

#
# FROM: :LFS
# REF: Chapter6.65
#
RUN  buildscripts/build util-linux-2.30.1 prepare util-linux-2.30.1.tar.xz
COPY buildscripts/util-linux-2.30.1 buildscripts/
RUN  buildscripts/build util-linux-2.30.1

#
# FROM :LFS
# REF: Chapter6.66
#
RUN  buildscripts/build man-db-2.7.6.1 prepare man-db-2.7.6.1.tar.xz
COPY buildscripts/man-db-2.7.6.1 buildscripts/
RUN  buildscripts/build man-db-2.7.6.1

#
# FROM :LFS
# REF: Chapte6.67
#
RUN  buildscripts/build tar-1.29 prepare tar-1.29.tar.xz
COPY buildscripts/tar-1.29 buildscripts/
RUN  buildscripts/build tar-1.29

#
# FROM :LFS
# REF: Chapter6.68
#
RUN  buildscripts/build texinfo-6.4 prepare texinfo-6.4.tar.xz
COPY buildscripts/texinfo-6.4 buildscripts/
RUN  buildscripts/build texinfo-6.4

#
# FROM :LFS
# REF: Chapter6.69
# nice.
#
RUN  buildscripts/build vim-8.0.586 prepare vim-8.0.586.tar.bz2
COPY buildscripts/vim-8.0.586 buildscripts/
RUN  buildscripts/build vim-8.0.586

# Done building! Clean up.
RUN rm -rf *                                                                      \
           /tmp/*                                                                 \
           /tools                                                                 \
           /usr/lib/lib{bfd,bz2,com_err,e2p,ext2fs,fl{,_pic},ltdl,opcodes,ss,z}.a \
           /usr/src/*

# This might break stuff.
RUN mkdir /usr/share/locale.new                            \
 && mv /usr/share/locale{,.new}/locale.alias               \
 && rm -rf /usr/share/locale                               \
 && mv /usr/share/locale{.new,}                            \
 && rm /usr/lib/locale/locale-archive                      \
 && localedef --inputfile=en_US --charmap=ISO-8859-1 en_US \
 && localedef --inputfile=en_US --charmap=UTF-8      en_US.UTF-8

FROM scratch
COPY --from=staging / /

ENV HOME=/root                                                        \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    LANG=en_US.UTF-8                                                  \
    LC_ALL=en_US.UTF-8                                                \
    LANGUAGE=en_US.UTF-8
WORKDIR "$HOME"
SHELL   ["/bin/bash", "--login", "-c"]
CMD     ["/bin/bash", "--login"]
