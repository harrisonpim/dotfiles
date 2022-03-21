export pythonpath=$(brew --prefix python@3.10)/bin/python3.10
export PATH=$PATH":$HOME:$HOME/bin:/usr/local/opt:/usr/local/bin:$pythonpath"
typeset -U path

# nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source ~/.oh-my-zsh/oh-my-zsh.sh

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# starship theme
eval "$(starship init zsh)"

# aliases
alias tf="terraform"
alias c="code ."
alias ij="idea ."
alias bloop="~/.bloop/bloop"
alias j="jupyter lab &"
alias readme="python -m rich.markdown README.md -w 80"
alias generate-password='python -c "import secrets; print(secrets.token_urlsafe(32))"'
alias clean-python='isort ./**/*.py; black . --line-length 80; flake8 . --max-line-length 80 --ignore=F401'
alias aaa='aws-azure-login --profile default --no-prompt'
alias push='git push -u origin head'
alias groot='cd $(git rev-parse --show-toplevel)'
alias gs='git status'
alias get='git fetch && git pull && git branch --merged | egrep -v "(^\*master|main)" | xargs git branch -d'
alias yeet='push'
alias main='git checkout main'
alias python=$pythonpath
alias pip3='python -m pip3'

# jump around with z
. ~/z.sh

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


source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
