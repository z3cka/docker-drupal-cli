#!/bin/bash

# Copy SSH keys from host if available
# First see if we have a mount at /.ssh
if [ -f  /.ssh/id_rsa ]; then
  cp /.ssh/id_rsa* ~/.ssh/
  chmod 600 ~/.ssh/id_rsa*
# Or /.ssh-b2d
elif [ -f  /.ssh-b2d/id_rsa ]; then
  cp /.ssh-b2d/id_rsa* ~/.ssh/
  chmod 600 ~/.ssh/id_rsa*
# Otherwise copy from /.home/.ssh if available
elif [ -f  /.home/.ssh/id_rsa ]; then
  cp /.home/.ssh/id_rsa* ~/.ssh/
  chmod 600 ~/.ssh/id_rsa*
fi

# Execute passed CMD arguments
exec "$@"
