GIT_ROOT=$(git rev-parse --show-toplevel)

ln -s $GIT_ROOT/files/.zshrc ~/.zshrc
ln -s $GIT_ROOT/files/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

