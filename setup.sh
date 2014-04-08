#!/bin/bash -x
apt-get update && apt-get upgrade

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
  sudo apt-get install git
  ln -s $HOME/dotfiles/files/.gitconfig $HOME/.gitconfig
}




echo "Do you want to apply the changes from https://fixubuntu.com/?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash; break;;
        No ) break;;
    esac
done
echo

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
  echo 
fi

function install_ssh_key {
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
echo "Do you want to generate a new ssh key?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_ssh_key; break;;
        No ) break;;
    esac
done
echo

echo "Do you want to install Sublime Text 3?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_sublimetext; break;;
    No ) break;;
  esac
done
echo

echo "Do you want to install build essentials and checkinstall?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) sudo apt-get install build-essential checkinstall; break;;
    No ) break;;
  esac
done
echo


function install_source_code_pro {
  rm -f SourceCodePro_FontsOnly-1.01*
  wget http://downloads.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip
  unzip SourceCodePro_FontsOnly-1.017.zip
  sudo mkdir -p /usr/share/fonts/custom
  ls -l SourceCodePro_FontsOnly-1.017/OTF/
  sudo cp SourceCodePro_FontsOnly-1.017/OTF/*.otf /usr/share/fonts/custom/
  rm -rf SourceCodePro_FontsOnly-1.017*
  sudo fc-cache -f -v
  echo "Do you install the gnome-tweak-tool to set the default system fonts?"
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) sudo apt-get install gnome-tweak-tool && gnome-tweak-tool; break;;
      No ) break;;
    esac
  done
  echo
}
echo "Do you want to install Adobes Source Code Pro Font?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_source_code_pro; break;;
    No ) break;;
  esac
done
echo

function install_ohmyzsh {
  sudo apt-get install zsh
  wget --no-check-certificate http://install.ohmyz.sh -O - | sh
  rm -f ~/.zshrc
  ln -s $HOME/dotfiles/files/.zshrc $HOME/.zshrc
}
echo "Do you want to install zsh/Oh-My-Zsh?"
select yn in "Yes" "No"; do
  case $yn in
    Yes ) install_ohmyzsh; break;;
    No ) break;;
  esac
done
echo
