export ZSH=$(echo ~/.oh-my-zsh)
export PATH=$PATH":$HOME:$HOME/bin:/usr/local/bin"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# theme
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
alias get='git fetch && git pull && git branch --merged | egrep -v "(^\*master|main)" | xargs git branch -d'
alias yeet='push' 
alias main='git checkout main' 



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

