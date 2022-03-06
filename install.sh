CASKS=0
for arg in "$@"
do
    case $arg in
        --casks)
        CASKS=1
        shift
        ;;
    esac
done

if ! command -v brew &> /dev/null; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing packages with brew..."
brew bundle --file=files/Brewfile

# if the user has added the --casks flag, install cask apps
if [ $CASKS -eq 1 ]; then
  echo "Installing cask apps..."
  brew bundle --file=files/Brewfile.casks
fi

if ! command -v omz &> /dev/null; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


echo "Installing fonts..."
(
    git clone https://github.com/powerline/fonts.git && 
    sh ./fonts/install.sh && 
    rm -rf ./fonts
) > /dev/null 2>&1

echo "Installing packages with pip..."
/opt/homebrew/bin/pip3 install -qqU pip 
/opt/homebrew/bin/pip-compile files/requirements.in --output-file=files/requirements.txt --quiet
/opt/homebrew/bin/pip3 install -qqr files/requirements.txt

ROOT="$(git rev-parse --show-toplevel)"

echo "Setting cli config..."
mkdir -p $HOME/.config
ln -sF $ROOT/files/starship.toml $HOME/.config/starship.toml
ln -sF $ROOT/files/.zshrc $HOME/.zshrc
ln -sF $ROOT/files/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

if gh auth status > /dev/null 2>&1 ; then
    echo "GitHub already configured"
else
    gh auth login
fi

echo "Setting git config..."
cp $ROOT/files/.gitconfig.clean $ROOT/files/.gitconfig
ln -sF $ROOT/files/.gitconfig $HOME/.gitconfig
ln -sF $ROOT/files/.gitignore $HOME/.gitignore
nbstripout --install --global > /dev/null 2>&1
dotenv-stripout install --global > /dev/null 2>&1

echo "Done!"
