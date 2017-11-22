ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/lfs-bootstrap:$GIT_BRANCH

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
