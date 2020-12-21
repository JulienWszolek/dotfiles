### ZSH ###
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="alanpeabody"
source $ZSH/oh-my-zsh.sh


### CONFIG VARIABLES ###
LOAD_FUNCTIONS=true


### FUNCTIONS ###
if $LOAD_FUNCTIONS ; then
    ## ALIAS ##
    alias hidden="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
    alias show="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"


    ## ALIAS FUNCTIONS ###
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
fi


### OVERRIDE SOURCE ####
source ~/.zsh_override

