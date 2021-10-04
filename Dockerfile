FROM python:3.8-slim
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
  cron \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/src/app/mloader-download.sh /etc/cron.weekly/mloader-download 

RUN python -m venv /usr/src/app/venv
ENV PATH="/usr/src/app/venv/bin:$PATH"

RUN pip install --upgrade pip && pip install mloader

CMD cron -f

