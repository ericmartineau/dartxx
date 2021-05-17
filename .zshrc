#  to your oh-my-zsh installation.
export ZSH="/Users/ericm/.oh-my-zsh"
ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=13
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

export NODE_VERSIONS=~/.nvm/versions/node
export NODE_VERSION_PREFIX=v

eval "$(/usr/local/bin/rbenv init -)"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(gitfast colorize github gradle jira virtualenv swiftpm pip python brew osx fasd httpie dirhistory dircycle git-extras postgres rsync sublime urltools web-search history jsontools zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# Preferred editor for local and remote sessions
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/ericm/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload bashcompinit
bashcompinit

source ~/.profile
source ~/.fastlane/completions/completion.zsh

export PATH="~/bin:$PATH"
eval "$(direnv hook zsh)"

fpath=(~/.zsh $fpath)

# Hack to brute force the swift completinos
compdef _swift swift

export PATH="/Users/ericm/.ebcli-virtual-env/executables:$PATH"

unset sunnyservers
sunnyservers() {
	cd ~/sunny/sunnyslack && gw :waypoints:run --args="-profiles=ericm,mariadb,devserver" &
	cd ~/sunny/sunnynode && npm run start &
}

killjobs () {
    local kill_list=$(jobs)
    echo $kill_list
    if [ -n "$kill_list" ]; then
        # this runs the shell builtin kill, not unix kill, otherwise jobspecs cannot be killed
        # the `$@` list must not be quoted to allow one to pass any number parameters into the kill
        # the kill list must not be quoted to allow the shell builtin kill to recognise them as jobspec parameters
    	kill $@
    else
        return 0
    fi

}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ericm/keap/smart-forms-api/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ericm/keap/smart-forms-api/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ericm/keap/smart-forms-api/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ericm/keap/smart-forms-api/google-cloud-sdk/completion.zsh.inc'; fi
