#!/bin/sh -e

DST_DIR=/usr/src/app/mloader
SRC_REPO=${SRC_REPO:-https://github.com/hurlenko/mloader.git}
BRANCH_NAME=${BRANCH_NAME:-master}

if [ ! -d $DST_DIR/.git ]; then
	mkdir -p $DST_DIR
	echo cloning mloader source from $SRC_REPO to $DST_DIR...
	git clone --branch $BRANCH_NAME $SRC_REPO $DST_DIR || echo error: failed to clone $BRANCH_NAME repository.
else
	echo updating mloader source in $DST_DIR from $SRC_REPO...
	cd $DST_DIR && \
		git config core.filemode false && \
		git config pull.rebase false && \
		git pull origin $BRANCH_NAME || echo error: unable to update $BRANCH_NAME repository.
fi

exec cron -f

