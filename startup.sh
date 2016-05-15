#!/bin/bash

# Copy Acquia Cloud API credentials
# @param $1 path to the home directory (parent of the .acquia directory)
copy_dot_acquia ()
{
  local path="$1/.acquia/cloudapi.conf"
  if [ -f $path ]; then
    echo "Copying Acquia Cloud API settings in $path from host..."
    mkdir -p ~/.acquia
    cp $path ~/.acquia
  fi
}

# Copy Drush settings from host
# @param $1 path to the home directory (parent of the .drush directory)
copy_dot_drush ()
{
  local path="$1/.drush"
  if [ -d $path ]; then
    echo "Copying Drush settigns in $path from host..."
    cp -r $path ~
  fi
}

# Copy Acquia Cloud API credentials from host if available
copy_dot_acquia '/.home' # Generic
copy_dot_acquia '/.home-linux' # Linux (docker-compose)
copy_dot_acquia '/.home-b2d' # boot2docker (docker-compose)

# Copy Drush settings from host if available
copy_dot_drush '/.home' # Generic
copy_dot_drush '/.home-linux' # Linux (docker-compose)
copy_dot_drush '/.home-b2d' # boot2docker (docker-compose)

# Create proxy-socket for ssh-agent
sudo rm /home/docker/.ssh/docker
sudo socat UNIX-LISTEN:/home/docker/.ssh/docker,fork UNIX-CONNECT:/sshagent/socket &
sudo chown docker /home/docker/.ssh/docker

# Reset home directory ownership
sudo chown $(id -u):$(id -g) -R ~

# Execute passed CMD arguments
exec "$@"
