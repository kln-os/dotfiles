echo "=== Starting installation of dotfiles ==="

# Dotfiles to manage
dotfiles=(
    .zshrc 
    .zshenv 
    .tmux.conf 
    .tmux.reset.conf 
    .config/kitty/kitty.conf
)

# Clean up individual files
for file in "${dotfiles[@]}"; do
    if [ -L "$HOME/$file" ]; then
        echo "$file is already a symlink. Removing it."
        rm -rf "$HOME/$file"
    elif [ -f "$HOME/$file" ]; then
        echo "$file already exists. Backing up to $file.bak."
        mv "$HOME/$file" "$HOME/$file.bak"
    else
        echo "$file not found."
    fi
done

# Special handling for nvim directory
nvim_dir="$HOME/.config/nvim"
if [ -L "$nvim_dir" ]; then
    echo "Neovim config is already a symlink. Removing it."
    rm -rf "$nvim_dir"
elif [ -d "$nvim_dir" ]; then
    echo "Neovim config directory exists. Backing up to $nvim_dir.bak."
    mv "$nvim_dir" "$nvim_dir.bak"
else
    echo "Neovim config directory not found."
fi

echo "Applying stow for dotfiles..."
stow -v -t ~ zsh tmux kitty nvim 

echo "-----------------------------------------"