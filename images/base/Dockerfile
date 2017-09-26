FROM alpine:latest

# Command-line config.
ARG INSTALL_DOCS

# Static config. Feel free to make it not static, and fiercly scold anyone referring to the values without the keys.
ENV ROOT_HOME=/root
WORKDIR "${ROOT_HOME}"
COPY packages*.apk "${ROOT_HOME}"/

# So we can get wild with scripting.
RUN BOOTSTRAP_PACKAGES=($(<packages-bootstrap.apk)) \
    apk add --no-cache --virtual bootstrap "${BOOTSTRAP_PACKAGES[@]}"

# Now let's get wild with scripting.
ENTRYPOINT ["/usr/bin/env", "bash", "-c"]

RUN BASE_PACKAGES=($(<packages.apk)) \
    apk add --no-cache --virtual base "${BASE_PACKAGES[@]}" && \
    if [[ "${INSTALL_DOCS}" != 'false' ]]; then \
      DOC_PACKAGES=($(packages-docs.apk) \
                    $(sed -En 's/^([^=]+)=(.*)$/\1-doc=\2/p' $(cat packages.apk packages-bootstrap.apk))) \
      apk add --no-cache --virtual docs "${DOC_PACKAGES[@]}"; \
    fi

ARG ROOT_HOME_TEMPLATE=root-home-template
COPY "${ROOT_HOME_TEMPLATE}"/* "${ROOT_HOME}"/
