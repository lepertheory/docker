FROM alpine:latest

# Command-line config.
ARG INSTALL_DOCS

# Static config. Feel free to make it not static, and fiercly scold anyone referring to the values without the keys.
ENV ROOT_HOME=/root
WORKDIR "${ROOT_HOME}"
COPY packages*.apk "${ROOT_HOME}"/

# So we can get wild with scripting.
RUN apk add --no-cache --virtual bootstrap $(cat packages-bootstrap.apk)

# Now let's get wild with scripting.
ENTRYPOINT ["/usr/bin/env", "bash"]

RUN apk add --no-cache --virtual base $(<packages.apk) && \
    if [[ "${INSTALL_DOCS}" != 'false' ]]; then \
      apk add --no-cache --virtual docs $(<packages-docs.apk) \
                                        $(sed -En 's/^([^=]+)=(.*)$/\1-doc=\2/p' < packages.apk) \
                                        $(sed -En 's/^([^=]+)=(.*)$/\1-doc=\2/p' < packages-bootstrap.apk); \
    fi

ARG ROOT_HOME_TEMPLATE=root-home-template
COPY "${ROOT_HOME_TEMPLATE}"/* "${ROOT_HOME}"/
