##### Nvim

alias vim='nvim'
alias vi='nvim'

export EDITOR=vim

alias temp='vim "temp_$(date "+%Y_%m_%dT%H_%M_%S")"'

##### Git Stuff

# Pre-req brew install gh
function pr_view() {
  gh pr view --web
}

function pr_create_draft() {
  gh pr create --draft
}

function pr_create() {
  gh pr create
}

function gprog(){
  git commit -m 'in progress'
}

function recent_br(){
  git for-each-ref --sort=committerdate refs/heads/ | tail -10 -r | awk '{print $3}' | cut -c 12-
}

function git_cur_br(){
  git br | grep \* | awk '{print $2}'
}

function gpo {
  git push origin $(git_cur_br)
}

alias gds='git diff --staged'

alias git_cont='git reset --soft $(git log | grep commit | head -2 | tail -1 | sed s/"commit "//)'

####### Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

######## Git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

autoload -Uz compinit && compinit

###### Command-line Prompt
COLOR_DEF=$'%f'
COLOR_DIR=$'%F{green}'
COLOR_GIT=$'%F{yellow}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} '

########## Grepping and Finding ###############

function mg (){
  git grep -10 -p --heading --line-number --break --untracked "$1" -- "."
}

######### ES LINT #############
function es_lint_fix () {
  npx eslint --fix "$1"
}

############ Ruby ##################
alias be='bundle exec'

############ MISC ##################

alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

########### Node ##################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# automatically use the node version specified in project root 
# based on the .nvmrc file

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

########### c-tags ############
## To install ctags on Mac OS:
#  1.  brew install --HEAD universal-ctags
#  2.  ctags --version

export PATH="/usr/local/bin:$PATH"

ctags_typescript() {
  ctags -R --languages=typescript --exclude=.git --exclude=node_modules .
}
