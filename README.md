# farmcoolcow/rclone-cron
[![](https://img.shields.io/badge/  FROM  -farmcoolcow/rclone-lightgray.svg)](https://hub.docker.com/r/farmcoolcow/rclone) ![](https://images.microbadger.com/badges/commit/farmcoolcow/rclone-cron.svg) ![](https://images.microbadger.com/badges/image/farmcoolcow/rclone-cron.svg) ![](https://images.microbadger.com/badges/license/farmcoolcow/rclone-cron.svg)

---

## What is Rclone ?

*rsync for cloud storage*

Rclone is a command line program to sync files and directories to and from cloud storage.
More informations on [the official Rclone website](http://rclone.org/).

---

## How to use this image

This image is based on [farmcoolcow/rclone](https://hub.docker.com/r/farmcoolcow/rclone), which is more appropriate for using the rclone command line directly.  
I recommend using **farmcoolcow/rclone** if you want to create or edit the rclone configuration file, or if you want to sync your files only once.

The default **ENTRYPOINT** is ```/entrypoint_crond.sh``` and the default **CMD** is ```-f```.

The available environment variables are:
  * ```PUID``` (default = **1000**)  
    The user id of the user created inside the docker container.
  * ```PGID``` (default = **1000**)  
    The group id of the user created inside the docker container.

  > Use the environment variables ```PUID``` and ```PGID``` to execute rclone with the **uid** and **gid** of your user. This prevents permission problems while accessing your data.


  * crontab file:
  
  > Syncs your data directory with your cloud storage every two hours. Uses a lock file to prevent the execution if the previous execution is not yet finished. Creates a new unique log file in your logs directory.  
  > Take a look ast [the rclone command list](http://rclone.org/commands/) to see all the available commands.
  
  ```crontab
  0 */2 * * * flock -n ~/rclone.lock rclone sync --log-file /logs/rclone.$(date +%Y%m%d_%H%M%S).log /data cloudstorage: &
  ```
  
  ---
  
  * Docker command:

  ```sh
  docker run -d \
    -e PUID=$(id -u $(whoami)) \
    -e PGID=$(id -g $(whoami)) \
    -v <PATH_TO_YOUR_CONF>:/home/.rclone.conf \
    -v <PATH_TO_YOUR_DATA>:/data \
    -v <PATH_TO_YOUR_CRONTAB>:/crontab \
    -v <PATH_TO_YOUR_LOGS>:/logs \
    farmcoolcow/rclone
  ```
  
  > Replace ```<PATH_TO_YOUR_CONF>``` with the file-path of your rclone configuration file.  
  > Replace ```<PATH_TO_YOUR_DATA>``` with the directory-path of your data directory.  
  > Replace ```<PATH_TO_YOUR_CRONTAB>``` with the file-path of your crontab file.  
  > Replace ```<PATH_TO_YOUR_LOGS>``` with the directory-path of your log directory.
