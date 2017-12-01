# FIXME: Replace this. No longer supported, just for reference.

FROM alpine:latest

# Command-line config.
ARG INSTALL_DOCS

# Static config. Feel free to make it not static, and fiercly scold anyone referring to the values without the keys.
ENV ROOT_HOME=/root
WORKDIR "${ROOT_HOME}"

# So we can get wild with scripting.
RUN ["/sbin/apk", "add", "--no-cache", "--virtual", "bash", "bash=4.3.48-r1"]
ENV SHELL="/bin/bash"
ENTRYPOINT ["/usr/bin/env", "bash"]

# Standard packages.
COPY packages*.apk setup "${ROOT_HOME}"/
RUN ["./setup"]

# Add additional terminal types.
COPY terminfo_source/ "${ROOT_HOME}"/terminfo_source/
COPY compile_terminfo "${ROOT_HOME}"/
RUN ./compile_terminfo "${ROOT_HOME}"/terminfo_source

# Set up root user environment.
ARG ROOT_HOME_TEMPLATE=root-home-template
COPY "${ROOT_HOME_TEMPLATE}"/* "${ROOT_HOME}"/
