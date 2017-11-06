ARG GIT_BRANCH
ARG TAG_BASE
FROM ${TAG_BASE}/apt-offline:$GIT_BRANCH AS staging

#
# FROM: :LFS
# REF: Chapter2.2
#
RUN PACKAGES=($(<"${APT_OFFLINE}"/packages)) \
  ; apt-get install --yes "${PACKAGES[@]}"   \
 && apt-get clean   --yes                    \
 && rm -rf "${APT_OFFLINE}"                  \
           /var/cache/apt/archives/*         \
           /var/lib/apt/lists/*

RUN rm /bin/sh \
 && ln -s /bin/bash /bin/sh \
 && update-alternatives --set awk /usr/bin/gawk

FROM scratch
COPY --from=staging / /
SHELL ["/bin/bash", "-c"]
CMD ["/bin/bash"]
