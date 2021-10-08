#!/bin/bash

#### EDIT THE MLOADER_TITLES VARIABLE WITH THE DESIRED TITLES.

# 700007 MASHLE
# 700005 One Piece
# 700003 My Hero Academia
# 100006 boruto eng
# 100012 dragon ball super eng
# 700006 black clover fr
# 100010 dr stone eng
# 100171 Dandadan
# 100056 spy x family
# 100021 platinum end eng

MLOADER_TITLES="-t 700007 -t 700005 -t 700003 -t 100006 -t 100012 -t 700006 -t 100010 -t 100171 -t 100056 -t 100021"

#############################################
cd $DST_DIR

if [ "${DOCKER_FILE:-Dockerfile}" == "source.Dockerfile" ]; then
  MLOADER_CMD="python -m mloader"
else
  MLOADER_CMD="mloader"
fi

su mloader -c "$MLOADER_CMD -o /usr/src/app/downloads -l -r $MLOADER_TITLES 2>&1 | tee ./cron.log"

