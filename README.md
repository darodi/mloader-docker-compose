# mloader-docker-compose
Mangaplus Downloader docker compose
to  download manga from mangaplus.shueisha.co.jp


## docker from pip package

* mloader in the container is the pip package
* the crontab runs weekly
* volume bind for downloads

### Installation

* edit mloader-download.sh with de desired titles
* Build and start the container

```bash
docker-compose up --build -d
```

### Updating
* only needed if mloader pip version changes
* Stop the containers: `docker-compose down && docker-compose rm`
* Update docker scripts from git: git pull origin master and apply any necessary modifications to mloader-download.sh
* Rebuild and start the containers: `docker-compose up --build -d`



## docker from git sources

* mloader updates from git repository on container restart
* the crontab runs daily
* volume bind for mloader source code (and download directory inside it)

### Installation
* edit mloader-download-source.sh with de desired titles
* edit env variables in docker-compose-source.yml

```bash
    environment:
      - SRC_REPO=https://github.com/darodi/mloader.git
      - BRANCH_NAME=develop
```

* Build and start the container

```bash
docker-compose -f docker-compose-source.yml up --build -d
```

### Updating
* Stop the containers: `docker-compose down && docker-compose rm`
* Update docker scripts from git: git pull origin master and apply any necessary modifications to mloader-download-source.sh, docker-compose-source.yml
* Rebuild and start the containers: `docker-compose -f docker-compose-source.yml up --build -d`
