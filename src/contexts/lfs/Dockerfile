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
RUN MACHINE="$(uname --machine)"        \
  ; TARGET="$MACHINE"-pc-linux-gnu      \
  ; mv /tools/bin/{ld,ld-old}           \
 && mv /tools/"$TARGET"/bin/{ld,ld-old} \
 && mv /tools/bin/{ld-new,ld}           \
 && ln --symbolic /tools/bin/ld /tools/"$TARGET"/bin/ld
RUN gcc -dumpspecs | sed --expression='s@/tools@@g'                                    \
                         --expression='/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
                         --expression='/\*cpp:/{n;s@$@ -isystem /usr/include@}'        \
    > "$(dirname "$(gcc --print-libgcc-file-name)")"/specs
RUN echo 'int main(){}' > dummy.c                                                               \
 && cc --verbose -Wl,--verbose --output=dummy dummy.c &> dummy.log                              \
 && readelf --program-headers dummy | grep --quiet ': /lib'                                     \
 && [[ "$(grep '^attempt to open /usr/lib/crt[1in]\.o succeeded$' dummy.log | wc --lines)" == 3 ]] \
 && rm dummy{,.{c,log}}

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
