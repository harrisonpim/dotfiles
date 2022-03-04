echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing packages with brew..."
brew bundle --file=files/Brewfile

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing packages with pip..."
/opt/homebrew/bin/pip3 install -qqU pip 
/opt/homebrew/bin/pip3 install -qqr files/requirements.txt

echo "Setting cli config..."
mkdir -p ~/.config
rm -f ~/.config/starship.toml
ln -s files/starship.toml ~/.config/starship.toml

rm -f ~/.zshrc
ln -s files/.zshrc ~/.zshrc

rm -f ~/Library/Preferences/com.googlecode.iterm2.plist
ln -s files/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

echo "Done!"
