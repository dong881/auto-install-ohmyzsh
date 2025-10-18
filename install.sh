#!/bin/bash
# Fully automatic install script for Oh My Zsh, bira theme, plugins - non-interactive!

# 1. Install zsh (if not installed)
sudo apt update && sudo apt install zsh -y

# 2. Oh My Zsh FULL unattended install: no questions, no interactive prompts
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# 3. Set theme and plugins by editing .zshrc
ZSHRC="$HOME/.zshrc"
# Change theme to 'bira'
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="bira"/' $ZSHRC
# Set plugins
sed -i 's/^plugins=(.*)/plugins=(zsh-autosuggestions zsh-syntax-highlighting)/' $ZSHRC

# 4. Install plugins (no prompt)
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 5. Auto chsh to zsh (no confirmation)
chsh -s $(which zsh) $USER

# 6. (Optional) Source zshrc if running inside zsh shell
# if [ "$SHELL" = "$(which zsh)" ]; then source $ZSHRC; fi

echo "Oh My Zsh installation is fully automated and complete! Please restart your terminal or run 'zsh' to start using it."
