FROM python:3.8-slim
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
  cron \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/src/app/cron.sh /etc/cron.weekly/mloader-download \
  && python -m venv /usr/src/app/venv

ENV PATH=/usr/src/app/venv:/usr/src/app/venv/bin:$PATH
ENV DST_DIR=/usr/src/app/mloader

RUN pip install --upgrade pip && pip install mloader

ADD startup.sh /usr/src/app

CMD /usr/src/app/startup.sh
