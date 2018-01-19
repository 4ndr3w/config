# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# ROS env
if [ -f /.dockerenv ]; then
    source /opt/ros/kinetic/setup.zsh
#    source ~/Sailbot_ROS/devel/setup.zsh
#    source /home/andrew/ros/dragglebot/devel/setup.zsh 
    source ~/omnirosv2/devel/setup.zsh
    source ~/iarc7/devel/setup.zsh
  export MORSE_BLENDER="/home/andrew/iarc7/blender-2.78c-linux-glibc219-x86_64/blender"
#
fi


export TERM=xterm-256color
# Path to your oh-my-zsh installation.
export ZSH=/home/andrew/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lambda"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias catkin_make="catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python2"



#source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
stty -ixon
export arduino_location="/home/andrew/arduino-1.8.5"

export EDITOR=vim

ros() {
    CMD="${@}"
    if [[ $CMD == "" ]]; then 
        CMD="zsh"
    fi
    ROS_DOCKER_ARGS=""
    case $- in
        *s*) ROS_DOCKER_ARGS="-it"
    esac
    docker start ros > /dev/null
    docker exec $ROS_DOCKER_ARGS ros /bin/zsh -c "cd \"`pwd`\" && source /opt/ros/kinetic/setup.zsh && $CMD"
}

alias wkupdate="python ~/powerbar/helpers/wanikani.py once > /tmp/topbar.pipe"

alias matlab-launch="matlab -desktop"
alias matlab-cli="matlab -nojvm -nodisplay -nosplash"
alias devrosuri="export ROS_MASTER_URI=http://172.16.1.2:11311"

# Aliases not inside the container
if [ ! -f /.dockerenv ]; then
  for c in `cat ~/.config/ros-commands`
  do
    eval "alias \"$c\"=\"ros $c \$@\""
  done
fi

