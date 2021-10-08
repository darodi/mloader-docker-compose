# first stage
FROM python:3.8 AS builder

ENV SRC_REPO=${SRC_REPO:-https://github.com/hurlenko/mloader.git}
ENV BRANCH_NAME=${BRANCH_NAME:-master}

RUN python -m venv /usr/src/app/venv

ENV PATH="/usr/src/app/venv/bin:$PATH"

# install dependencies to the virtual env
RUN export SRC_REPO_PATH=${SRC_REPO#*github.com/} \
   && export REQ_URL=https://raw.githubusercontent.com/${SRC_REPO_PATH%.git}/${BRANCH_NAME}/requirements.txt \
   && wget $REQ_URL \
   && pip install -r requirements.txt

# second unnamed stage
FROM python:3.8-slim
WORKDIR /usr/src/app

# copy only the virtual environment from the first stage image
COPY --from=builder /usr/src/app/venv /usr/src/app/venv

# update PATH environment variable
ENV PATH=/usr/src/app/venv:/usr/src/app/venv/bin:$PATH
ENV DST_DIR=/usr/src/app/mloader

RUN apt-get update && apt-get install -y \
  cron \
  git \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/src/app/cron.sh /etc/cron.daily/mloader-download

ADD startup.sh /usr/src/app

CMD /usr/src/app/startup.sh
