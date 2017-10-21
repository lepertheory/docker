FROM lfs/bootstrap/apt-offline:master

ARG UPDATE_PACKAGES=false
ENV APT_OFFLINE=/root/apt-offline

VOLUME "${APT_OFFLINE}"
ADD apt-offline/* "${APT_OFFLINE}"/

RUN UPDATE_SIG="${APT_OFFLINE}"/apt-get-update.sig                    \
  ; UPDATE_ZIP="${APT_OFFLINE}"/apt-get-update.zip                    \
  ; if [[ "${UPDATE_PACKAGES}" == 'true' ]]; then                     \
      rm -f           "${UPDATE_SIG}"                                 \
 &&   apt-offline set "${UPDATE_SIG}" --update                        \
 &&   apt-offline get "${UPDATE_SIG}" --bundle="${UPDATE_ZIP}"        \
                                      --download-dir="${APT_OFFLINE}" \
  ; fi || true                                                        \
 && apt-offline install ${UPDATE_ZIP}

RUN INSTALL_SIG="${APT_OFFLINE}"/apt-get-install.sig                       \
  ; INSTALL_ZIP="${APT_OFFLINE}"/apt-get-install.zip                       \
  ; PACKAGES=($(<"${APT_OFFLINE}"/packages))                               \
  ; if [[ "${UPDATE_PACKAGES}" == 'true' ]]; then                          \
      rm -f           "${INSTALL_SIG}"                                     \
 &&   apt-offline set "${INSTALL_SIG}" --install-packages "${PACKAGES[@]}" \
 &&   apt-offline get "${INSTALL_SIG}" --bundle="${INSTALL_ZIP}"           \
                                       --download-dir="${APT_OFFLINE}"     \
  ; fi || true                                                             \
 && apt-offline install "${INSTALL_ZIP}"

RUN PACKAGES=($(<"${APT_OFFLINE}"/packages)) \
  ; apt-get install --yes "${PACKAGES[@]}"   \
 && apt-get clean   --yes                    \
 && rm -rf /var/cache/apt/archives/*         \
           /var/lib/apt/lists/*
