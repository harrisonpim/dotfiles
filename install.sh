echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing packages with brew..."
brew bundle --file=files/Brewfile

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing packages with pip..."
/opt/homebrew/bin/pip3 install -qqU pip 
/opt/homebrew/bin/pip3 install -qqr files/requirements.txt

ROOT="$(git rev-parse --show-toplevel)"

echo "Setting cli config..."
mkdir -p $HOME/.config
rm -f $HOME/.config/starship.toml
ln -s $ROOT/files/starship.toml $HOME/.config/starship.toml

rm -f $HOME/.zshrc
ln -s $ROOT/files/.zshrc $HOME/.zshrc

rm -f $HOME/Library/Preferences/com.googlecode.iterm2.plist
ln -s $ROOT/files/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist

echo "Done!"
