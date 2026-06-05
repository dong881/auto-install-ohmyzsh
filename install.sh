#!/bin/bash
# Fully automatic, idempotent install script for Oh My Zsh, theme, and plugins

echo "Starting Oh My Zsh installation..."

# 1. 更新並確保基本套件已安裝 (zsh, git, curl)
sudo apt update && sudo apt install -y zsh git curl

# 2. 安裝 Oh My Zsh (無人值守模式)
# 如果目錄已存在就跳過，避免報錯
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed. Skipping core installation."
fi

# 3. 明確定義變數與路徑 (避免依賴尚未建立的 zsh 環境變數)
ZSHRC="$HOME/.zshrc"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# 4. 安裝 Plugins (加入目錄檢查，避免 git clone 報錯)
echo "Installing plugins..."

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 5. 修改 .zshrc 設定
echo "Configuring .zshrc..."
if [ -f "$ZSHRC" ]; then
    # 設定主題為 bira
    sed -i 's/^ZSH_THEME=.*/ZSH_THEME="bira"/' "$ZSHRC"
    
    # [可選] 如果你想改用 Powerlevel10k，請註解掉上面那行，並取消註解下面這兩行：
    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    # sed -i 's#^ZSH_THEME=.*#ZSH_THEME="powerlevel10k/powerlevel10k"#' "$ZSHRC"

    # 設定 plugins (強烈建議保留預設的 git)
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
    echo "Error: $ZSHRC not found! Something went wrong with Oh My Zsh installation."
    exit 1
fi

# 6. 自動切換預設 Shell 為 zsh
# 使用 sudo 執行 chsh 可以避免一般使用者被要求輸入密碼或權限不足的問題
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    sudo chsh -s "$(which zsh)" "$USER"
fi

echo "====================================================="
echo "✅ Installation completely automated and successful!"
echo "➡️  Please run 'exec zsh' or restart your SSH session to apply changes."
echo "====================================================="
