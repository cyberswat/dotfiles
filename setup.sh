#!/bin/bash
wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash

# Install git
if dpkg --get-selections | grep -q "^git$" >/dev/null; then
  echo "Git is installed."
else
  sudo apt-get install git
fi

# Generate a new ssh key for github for this machine if one doesn't exist.
ssh-keygen -t rsa -C "kevin@cyberswat.com"
if [ ! -f ~/.ssh/github ]; then
  ssh-keygent -t rsa -C "kevin@cyberswat.com"
fi
