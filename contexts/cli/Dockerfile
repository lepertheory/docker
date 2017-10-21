#ARG GIT_BRANCH
#FROM base:${GIT_BRANCH:-master}
FROM base:master

RUN apk add --no-cache jq   jq-doc \
				               less less-doc \
                       tmux tmux-doc \
                       vim  vim-doc

VOLUME /root/config \
       /mnt/host \
       /mnt/repo
