#!/bin/bash

SRC_REPO=${SRC_REPO:-https://github.com/hurlenko/mloader.git}
BRANCH_NAME=${BRANCH_NAME:-master}

if ! id mloader >/dev/null 2>&1; then
	addgroup --gid ${OWNER_GID:-1000} mloader
  adduser --no-create-home --disabled-password -home $DST_DIR --gid ${OWNER_GID:-1000} --uid ${OWNER_UID:-1000} --gecos "" mloader
  mkdir -p /usr/src/app/downloads
  chown mloader:mloader /usr/src/app/downloads
  mkdir -p $DST_DIR
  chown mloader:mloader $DST_DIR
fi

if [ "${DOCKER_FILE:-Dockerfile}" == "source.Dockerfile" ]; then
  if [ ! -d $DST_DIR/.git ]; then
    echo cloning mloader source from $SRC_REPO to $DST_DIR...
    su mloader -c " git clone --branch $BRANCH_NAME $SRC_REPO $DST_DIR || echo error: failed to clone $BRANCH_NAME repository."
  else
    echo updating mloader source in $DST_DIR from $SRC_REPO...
    cd $DST_DIR && \
    su mloader -c "git config core.filemode false && \
      git config pull.rebase false && \
      git pull origin $BRANCH_NAME || echo error: unable to update $BRANCH_NAME repository."
  fi
fi

mkdir -p /usr/src/app/downloads
chown -R mloader:mloader /usr/src/app/downloads
echo done, launching cron
exec cron -f

