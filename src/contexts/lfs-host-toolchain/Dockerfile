ARG GIT_BRANCH
ARG TAG_BASE
FROM $TAG_BASE/apt-offline:$GIT_BRANCH AS staging

#
# FROM: :LFS
# REF: Chapter2.2
#
RUN PACKAGES=($(<"$APT_OFFLINE"/packages)) \
  ; apt-get install --yes "${PACKAGES[@]}" \
 && apt-get clean   --yes                  \
 && rm -rf "$APT_OFFLINE"/apt-offline-*    \
           /var/cache/apt/archives/*       \
           /var/lib/apt/lists/*

RUN rm /bin/sh \
 && ln -s /bin/bash /bin/sh \
 && update-alternatives --set awk /usr/bin/gawk

FROM  scratch
COPY  --from=staging / /

ENV     HOME=/root
WORKDIR "$HOME"
SHELL   ["/bin/bash", "--login", "-c"]
CMD     ["/bin/bash", "--login"]

ONBUILD ENV     HOME=/root
ONBUILD WORKDIR "$HOME"
ONBUILD SHELL   ["/bin/bash", "--login", "-c"]
ONBUILD CMD     ["/bin/bash", "--login"]
