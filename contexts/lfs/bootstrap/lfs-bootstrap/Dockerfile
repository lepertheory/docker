FROM lfs/bootstrap/host-toolchain:master

#
# 2.6
#
ARG LFS=/mnt/lfs

#
# 2.7 - Not needed.
#

#
# 3.1
#
COPY sources/* "${LFS}"/sources/
RUN chmod -v a+wt "${LFS}"/sources

#
# 3.2 - Follow book, leave in the ${SCRIPT_PATH}/../sources.
#

#
# 3.3 - Follow book
#

RUN mkdir -v "${LFS}"/tools
RUN ln -sv "${LFS}"/tools /

RUN groupadd lfs \
 && useradd --shell=/bin/bash --gid=lfs --create-home --skel=/dev/null lfs

RUN chown -v lfs:lfs "${LFS}"/{tools,sources}

USER lfs:lfs
COPY lfs_home/* /home/lfs/

WORKDIR "${LFS}"/sources

RUN tar -xf binutils-2.29.tar.bz2
RUN cd binutils-2.29                        \
 && mkdir -v build                          \
 && cd build                                \
 && ../configure --prefix=/tools            \
                 --with-sysroot="${LFS}"    \
                 --with-lib-path=/tools/lib \
                 --target="${LFS_TGT}"      \
                 --disable-nls              \
                 --disable-werror
RUN cd binutils-2.29/build && make
RUN if [[ "$(uname -m)" == 'x86_64' ]]; then \
      mkdir -v /tools/lib                    \
 &&   ln -sv lib /tools/lib64                \
  ; fi
RUN cd binutils-2.29/build && make install

RUN tar -xf gcc-7.2.0.tar.xz
RUN cd gcc-7.2.0                                          \
 && tar -xf ../mpfr-3.1.5.tar.xz && mv -v mpfr-3.1.5 mpfr \
 && tar -xf ../gmp-6.1.2.tar.xz  && mv -v gmp-6.1.2  gmp  \
 && tar -xf ../mpc-1.0.3.tar.gz  && mv -v mpc-1.0.3  mpc
RUN cd gcc-7.2.0 \
 && for file in gcc/config/{linux,i386/linux{,64}}.h; do                    \
      cp -uv "${file}"{,.orig}                                              \
 &&   sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g'                          \
          -e 's@/usr@/tools@g' "${file}".orig                  >  "${file}" \
 &&   echo                                                     >> "${file}" \
 &&   echo '#undef STANDARD_STARTFILE_PREFIX_1'                >> "${file}" \
 &&   echo '#undef STANDARD_STARTFILE_PREFIX_2'                >> "${file}" \
 &&   echo '#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"' >> "${file}" \
 &&   echo '#define STANDARD_STARTFILE_PREFIX_2 ""'            >> "${file}" \
 &&   touch "${file}".orig                                                  \
  ; done
RUN cd gcc-7.2.0                                                    \
 && if [[ "$(uname -m)" == 'x86_x64' ]]; then                       \
      sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64 \
  ; fi
RUN cd gcc-7.2.0                                                \
 && mkdir -v build                                              \
 && cd build                                                    \
 && ../configure --target="${LFS_TGT}"                          \
                 --prefix=/tools                                \
                 --with-glibc-version=2.11                      \
                 --with-sysroot="${LFS}"                        \
                 --with-newlib                                  \
                 --without-headers                              \
                 --with-local-prefix=/tools                     \
                 --with-native-system-header-dir=/tools/include \
                 --disable-nls                                  \
                 --disable-shared                               \
                 --disable-multilib                             \
                 --disable-decimal-float                        \
                 --disable-threads                              \
                 --disable-libatomic                            \
                 --disable-libgomp                              \
                 --disable-libmpx                               \
                 --disable-libquadmath                          \
                 --disable-libssp                               \
                 --disable-libvtv                               \
                 --disable-libstdcxx                            \
                 --enable-languages=c,c++
RUN cd gcc-7.2.0/build && make
RUN cd gcc-7.2.0/build && make install
