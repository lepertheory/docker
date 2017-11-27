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
FROM scratch
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
