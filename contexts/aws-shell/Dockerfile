ARG GIT_BRANCH=master
FROM awscli:${GIT_BRANCH}

RUN pip3 install aws-shell

ENTRYPOINT ["/usr/bin/aws-shell"]
