export ZSH="/Users/pimh/.oh-my-zsh"

ZSH_THEME="robbyrussell"
SPACESHIP_GIT_SYMBOL=""
SPACESHIP_TIME_SHOW=true
SPACESHIP_VENV_SHOW=false
SPACESHIP_CONDA_SHOW=false
SPACESHIP_PYENV_SHOW=false
SPACESHIP_EXEC_TIME_SHOW=false
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_GIT_STATUS_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_PHP_SHOW=false
SPACESHIP_PYTHON_SHOW=false
SPACESHIP_RUST_SHOW=false
SPACESHIP_GO_SHOW=false
SPACESHIP_VENV_SHOW=false
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_EMBER_SHOW=false
SPACESHIP_DOCKER_SHOW=false
HIST_STAMPS="yyyy-mm-dd"


plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# aliases
alias python='/usr/local/bin/python3'
alias git='/usr/local/bin/git'
alias tf="terraform"
alias c="code ."
alias ij="idea ."
alias bloop="/Users/pimh/.bloop/bloop"
alias j="jupyter lab &"
alias readme="python -m rich.markdown README.md -w 80"
alias generate-password='python -c "import secrets; print(secrets.token_urlsafe(32))"'
alias clean-python='isort ./**/*.py; black . --line-length 80; flake8 . --max-line-length 80 --ignore=F401'
alias aaa='aws-azure-login --profile default --no-prompt' 
alias push='git push -u origin head'
alias groot='cd $(git rev-parse --show-toplevel)'
alias get='git fetch && git pull && git branch --merged | egrep -v "(^\*master|main)" | xargs git branch -d'
alias yeet='push' 
alias main='git checkout main' 


fpath=($fpath "/Users/pimh/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

eval "$(rbenv init -)"

. ~/z.sh
export PATH=$PATH":$HOME/bin"
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc


# set iterm2 tab title
DISABLE_AUTO_TITLE="true"
is_git() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]
}
tab_title() {
  local "BETTER_PWD"
  if is_git; then
   BETTER_PWD=$(git rev-parse --show-toplevel)
  else
    BETTER_PWD=$(PWD)
  fi
  # sets the tab title
  echo -ne "\e]1;${BETTER_PWD##*/}\a"
}
add-zsh-hook precmd tab_title

