### ZSH ###
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="alanpeabody"
plugins=(
    git
    aws
)
source $ZSH/oh-my-zsh.sh


### EXPORT VARIABLES ####
export PATH="/usr/local/bin:$PATH"


### CONFIG VARIABLES ###
LOAD_NVM=false
LOAD_GCLOUD=false
LOAD_FUNCTIONS=true


### GO ###
export GOPATH="$HOME/go"


### NVM ###
if $LOAD_NVM ; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"
fi


### GCLOUD ###
if $LOAD_GCLOUD ; then
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f "$HOME/Sites/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Sites/google-cloud-sdk/path.zsh.inc"; fi
    
    # The next line enables shell command completion for gcloud.
    if [ -f "$HOME/Sites/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Sites/google-cloud-sdk/completion.zsh.inc"; fi
    
    export PROJECT_ID="$(gcloud config get-value project -q)"
else
    export PROJECT_ID="local"
fi


### ALIAS ###
# GIT #
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

# DOCKER #
alias dmysql="docker run --name mysql -e MYSQL_ROOT_PASSWORD=secret -p 3307:3306 -d mysql:5.7"
alias dpma="docker run --name myadmin -d --link mysql:db -p 8080:80 phpmyadmin/phpmyadmin"

# MAC OS #
alias hidden="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias show="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"


### FUNCTIONS ###
if $LOAD_FUNCTIONS ; then
    ## ALIAS ##
    alias git-sp="speedPush"
    alias git-sp-n="speedPushN"
    alias drm="dockerRmAll"
    alias drmv="dockerRmAllVolumes"
    alias dc-bu="dockerComposeBuildAndUpDetached"
    alias dc-e="dockerComposeExec"
    
    ########################
    # GIT SPEED PUSH       #
    ########################
    speedPush() {
        git add .
        git commit --amend --no-edit
        git push -f
    }
    
    ########################
    # GIT SPEED PUSH -n    #
    ########################
    speedPushN() {
        git add .
        git commit --amend --no-edit -n
        git push -f --no-verify
    }
    
    ########################
    # RM DOCKER CONTAINER  #
    ########################
    dockerRmAll() {
        docker stop $(docker ps -a -q)
        docker rm $(docker ps -a -q)
    }
    
    ########################
    # RM DOCKER VOLUMES    #
    ########################
    dockerRmAllVolumes() {
        docker volume rm $(docker volume ls -q)
    }
    
    ########################
    # DC BUILD AND UP -D   #
    ########################
    dockerComposeBuildAndUpDetached() {
        docker-compose build
        docker-compose up -d
    }
    
    ########################
    # DC EXEC              #
    # $1 = container       #
    # $2 = command         #
    ########################
    dockerComposeExec () {
        if [ $1 ] && [ $2 ]
        then
            docker-compose exec $1 $2
        else
            echo "Error : bad arguments"
        fi
    }
    
    ########################
    # MKDIR + CD           #
    # $1 = new folder name #
    ########################
    mkcd () {
        if [ $1 ]
        then
            mkdir $1
            cd $1
        else
            echo "Error : no argument"
        fi
    }
    
    ######################
    # BACK IN THE FILES  #
    # $1 = how much back #
    ######################
    b() {
        if [ $1 ]
        then
            i=$1
        else
            i=1
        fi
        
        count=2
        command='cd ..'
        while [ $count -le $i ]
        do
            command+="/.."
            (( count++ ))
        done
        
        eval $command
    }
fi
