FROM python3:${GIT_BRANCH:-master}

ENV BASHRC="${ROOT_HOME}"/.bashrc

RUN apk --no-cache add groff=1.22.3-r1                                              && \
    pip3 install awscli                                                             && \
    echo                                                             >> "${BASHRC}" && \
    echo '# Complete AWS commands with `aws ...`.'                   >> "${BASHRC}" && \
    echo 'complete -C "$(printf '%q' "$(which aws_completer)")" aws' >> "${BASHRC}"

VOLUME ["${ROOT_HOME}/.aws"]
