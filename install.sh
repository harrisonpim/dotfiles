echo "Installing packages..."
brew install zsh-autosuggestions zsh-syntax-highlighting starship > /dev/null 2>&1

GIT_ROOT=$(git rev-parse --show-toplevel)

echo "Setting cli config..."
mkdir -p ~/.config
rm -f ~/.config/starship.toml
ln -s $GIT_ROOT/files/starship.toml ~/.config/starship.toml

rm -f ~/.zshrc
ln -s $GIT_ROOT/files/.zshrc ~/.zshrc

rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s $GIT_ROOT/files/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

echo "Done!"