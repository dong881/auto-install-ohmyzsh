#!/bin/bash
# Fully automatic installation: Oh My Zsh + two plugins (autosuggestions, syntax-highlighting)
# Includes sudo privileges, theme configuration, and plugin installation

# Step 1: Install zsh
sudo apt update && sudo apt install zsh -y

# Step 2: Download and install Oh My Zsh (unattended mode)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Step 3: Set theme and plugins
ZSHRC="$HOME/.zshrc"
# Change theme to 'bira'
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="bira"/' $ZSHRC

# Update plugins list
sed -i 's/^plugins=(.*)/plugins=(zsh-autosuggestions zsh-syntax-highlighting)/' $ZSHRC

# Step 4: Install plugins according to Oh My Zsh instructions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Step 5: Reload zsh configuration
source $ZSHRC

echo "Installation complete! Please restart your terminal or run 'zsh' to activate Oh My Zsh and the plugins."
