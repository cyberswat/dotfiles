# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rails git ruby gem knife thor)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

PATH=$PATH:$HOME/packer
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

setopt=autocd
setopt=extendedglob

# Map the terminals interrupt to ctrl+x so that I can easily copy and paste.
stty intr \^X

export VAGRANT_DEFAULT_PROVIDER=vmware_workstation

# Here is where you put the stuff that shouldn't be visible in the public repository.
if [[ -r ~/.zshrcprivate ]]; then
    source ~/.zshrcprivate
fi

export DATA_BAGS_PATH=$HOME/nmd-chef/data_bags
export KITCHEN_LOG="debug"

# added by travis gem
[ -f /home/cyberswat/.travis/travis.sh ] && source /home/cyberswat/.travis/travis.sh
