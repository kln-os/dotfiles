#!/bin/bash

# Cập nhật hệ thống trước khi cài đặt
echo "Đang cập nhật hệ thống..."
sudo apt update -qq && sudo apt upgrade -y -qq > /dev/null 2>&1
echo "Update xong"

# 1. Cài đặt Zsh, Oh My Zsh và đặt Zsh làm shell mặc định
if ! command -v zsh &> /dev/null; then
    echo "Cài đặt Zsh..."
    sudo apt install -y zsh -qq > /dev/null 2>&1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Cài đặt Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
fi

if [ "$(echo $SHELL)" != "$(which zsh)" ]; then
    echo "Đặt Zsh làm shell mặc định..."
    sudo chsh -s $(which zsh) $USER > /dev/null 2>&1
fi



# 2. Cài đặt các plugin cho Zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions --quiet > /dev/null 2>&1
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting --quiet > /dev/null 2>&1

# 3. Cài đặt Miniconda
if [ ! -d "$HOME/miniconda" ]; then
    echo "Cài đặt Miniconda..."
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    bash miniconda.sh -b -p $HOME/miniconda > /dev/null 2>&1
    rm miniconda.sh
fi

export PATH="$HOME/miniconda/bin:$PATH"
conda config --set auto_activate_base false > /dev/null 2>&1
conda init zsh > /dev/null 2>&1

# 4. Cài đặt Neovim 
if ! command -v nvim &> /dev/null; then
    echo "Cài đặt Neovim..."
    sudo apt install -y software-properties-common -qq > /dev/null 2>&1
    sudo add-apt-repository ppa:neovim-ppa/unstable -y > /dev/null 2>&1
    sudo apt update -qq > /dev/null 2>&1
    sudo apt install -y neovim -qq > /dev/null 2>&1
fi

# 5. Cài đặt các công cụ bổ sung
for pkg in bat gpg stow; do
    dpkg -l | grep -q $pkg || sudo apt install -y $pkg -qq > /dev/null 2>&1
done

# Cài đặt eza
if ! command -v eza &> /dev/null; then
    echo "Cài đặt eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg > /dev/null 2>&1
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list > /dev/null 2>&1
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update -qq > /dev/null 2>&1
    sudo apt install -y eza -qq > /dev/null 2>&1
fi


# Cài đặt fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo "Cài đặt fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf --quiet > /dev/null 2>&1
    zsh
    yes | ~/.fzf/install > /dev/null 2>&1
fi

# Tải lại file .zshrc để áp dụng thay đổi
source ~/.zshrc

stow newVM nvim shortcut tmux zsh 

echo "Cài đặt hoàn tất!"
