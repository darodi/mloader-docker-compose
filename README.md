# mloader-docker-compose
Mangaplus Downloader docker compose
to  download manga from mangaplus.shueisha.co.jp
with a scheduled cron


## docker from pip package

* mloader in the container is the pip package
* cron runs **weekly**
* volume bind for downloads


## docker from git sources

* mloader updates from git repository on container restart
* cron runs **daily**
* volume bind for downloads

## Installation

* edit cron.sh and replace MLOADER_TITLES with the desired titles : 

```bash
#### EDIT THE MLOADER_TITLES VARIABLE WITH THE DESIRED TITLES.

# 700007 MASHLE
# 700005 One Piece

MLOADER_TITLES="-t 700007 -t 700005"
```


* create a .env file with your configuration. (copy .env-dist and edit values)

```bash
# This is only needed to use mloader from git sources, 
# comment those 3 lines to use mloader pip package instead
SRC_REPO=https://github.com/darodi/mloader.git
BRANCH_NAME=develop
DOCKER_FILE=source.Dockerfile

#Define the UID and GID used for the download volume
OWNER_UID=1000
OWNER_GID=1000

#might be needed if you have an old NAS
#COMPOSE_HTTP_TIMEOUT=200
```
you can determine the UID GID with the command `id`

```bash
user@DESKTOP:/home/user$ id
uid=1000(user) gid=1000(user)
```

* Build and start the container
`docker-compose up --build -d`

### Updating
* only needed 
  * **build from pip package** : if mloader pip version changes
  * **build from git sources** : if requirements.txt changes in git
* Stop the containers: `docker-compose down && docker-compose rm`
* Update docker scripts from this git: git pull origin master and apply any necessary modifications to .env file 
* Rebuild and start the container: `docker-compose up --build -d`

