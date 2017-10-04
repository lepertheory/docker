ARG GIT_BRANCH=master
FROM python3:${GIT_BRANCH}

ENV BASHRC="${ROOT_HOME}"/.bashrc

RUN ["./setup", "${BASHRC}"]

VOLUME ["${ROOT_HOME}/.aws"]
