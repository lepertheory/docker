FROM lfs/bootstrap/apt-offline:master AS staging

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

FROM scratch
COPY --from=staging / /
SHELL ["/bin/bash", "-c"]
CMD ["/bin/bash"]
