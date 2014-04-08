#!/bin/bash -x

function install_buildtools {
  sudo apt-get install build-essential checkinstall
}

function install_fixubuntu {
  wget -q -O - https://fixubuntu.com/fixubuntu.sh | bash
}

function install_git {
  sudo apt-get install git
  ln -s $HOME/dotfiles/files/.gitconfig $HOME/.gitconfig
}

function install_gnometweaktool {
  sudo apt-get install gnome-tweak-tool && gnome-tweak-tool &
}

function install_hipchat {
  sudo sh -c 'echo "deb http://downloads.hipchat.com/linux/apt stable main" > /etc/apt/sources.list.d/atlassian-hipchat.list'
  wget -O - https://www.hipchat.com/keys/hipchat-linux.key | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install hipchat 
}

function install_ohmyzsh {
  sudo apt-get install zsh
  wget --no-check-certificate http://install.ohmyz.sh -O - | sh
  rm -f ~/.zshrc
  ln -s $HOME/dotfiles/files/.zshrc $HOME/.zshrc
}

function install_sourcecodepro {
  rm -f SourceCodePro_FontsOnly-1.01*
  wget http://downloads.sourceforge.net/project/sourcecodepro.adobe/SourceCodePro_FontsOnly-1.017.zip
  unzip SourceCodePro_FontsOnly-1.017.zip
  sudo mkdir -p /usr/share/fonts/custom
  ls -l SourceCodePro_FontsOnly-1.017/OTF/
  sudo cp SourceCodePro_FontsOnly-1.017/OTF/*.otf /usr/share/fonts/custom/
  rm -rf SourceCodePro_FontsOnly-1.017*
  sudo fc-cache -f -v
}

function install_sshkey {
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

function install_everything {
  install_fixubuntu
  install_buildtools
  install_git
  install_hipchat
  install_ohmyzsh
  install_sshkey
  install_sourcecodepro
  install_sublimetext
}

sudo apt-get update

echo "What would you like to install?"
select abcdefghij in "everything" "buildtools" "fixubuntu" "git" "gnometweaktool" "hipchat" "ohmyzsh" "sshkey" "sourcecodepro" "sublimetext3"; do
  case $abcdefghij in
    everything ) install_everything;  break;;
    buildtools ) install_buildtools; break;;
    fixubuntu ) install_fixubuntu; break;;
    git ) install_git; break;;
    gnometweaktool ) install_gnometweaktool; break;;
    hipchat ) install_hipchat; break;;
    ohmyzsh ) install_ohmyzsh; break;;
    sshkey ) install_sshkey; break;;
    sourcecodepro ) install_sourcecodepro; break;;
    sublimetext3 ) install_sublimetext; break;;
  esac
done
echo

