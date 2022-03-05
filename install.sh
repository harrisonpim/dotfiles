echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing packages with brew..."
brew bundle --file=files/Brewfile

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
ln -sF $ROOT/files/.gitconfig $HOME/.gitconfig
nbstripout --install --global > /dev/null 2>&1
dotenv-stripout install --global > /dev/null 2>&1

echo "Done!"
