#!/bin/bash

function install_sublimetext {
  if [ ! -f /usr/bin/subl ]; then
    TEMPFILE=$(mktemp)
    wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb -O $TEMPFILE
    sudo dpkg -i $TEMPFILE
    rm $TEMPFILE
  else
    echo "Sublime Text appears to be installed ... skipping."
  fi
}

function install_git {
  apt-get update
  sudo apt-get install git
  ln -s $HOME/dotfiles/files/.gitconfig $HOME/.gitconfig
}

function install_build {
  apt-get update
  sudo apt-get install build-essential checkinstall
}

function install_ssh_cert {
  echo "Enter your email:   "
  read EMAIL
  echo
  echo "Confirm your email: "
  read EMAILCONFIRM
  echo
  while [ "$EMAIL" != "$EMAILCONFIRM" ]; do 
    echo "Enter your email:   "
    read EMAIL
    echo
    echo "Confirm your email: "
    read EMAILCONFIRM
    echo
  done

  ssh-keygen -t rsa -C "$EMAIL"
}


echo "Do you want to apply the changes from https://fixubuntu.com/?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash; break;;
        No ) break;;
    esac
done
echo ""

if dpkg --get-selections | grep -q "^git$" >/dev/null; then
  echo "Git is installed."
else
  echo "Do you want to install git?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) install_git; break;;
      No ) break;;
    esac
  done
  echo ""
fi

echo "Do you want to generate a new ssh key for services like github?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_ssh_cert; break;;
        No ) break;;
    esac
done
echo ""

echo "Do you want to install Sublime Text 3?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_sublimetext; break;;
    No ) break;;
  esac
done
echo ""

echo "Do you want to install build essentials?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_build; break;;
    No ) break;;
  esac
done
echo ""
