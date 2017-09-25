FROM python3:${GIT_BRANCH:-master}

ENV BASHRC="${ROOT_HOME}"/.bashrc

RUN pip3 install awscli                                                             && \
    echo                                                             >> "${BASHRC}" && \
    echo '# Complete AWS commands with `aws ...`.'                   >> "${BASHRC}" && \
    echo 'complete -C "$(printf '%q' "$(which aws_completer)")" aws' >> "${BASHRC}"
