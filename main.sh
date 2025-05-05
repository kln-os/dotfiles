echo "=== Starting installation of dotfiles ==="

echo "Applying stow for dotfiles..."
rm -rf ~/.zshrc ~/.config/atuin
SCRIPT_DIR=$(dirname "$(realpath "$0")")
chmod +x ${SCRIPT_DIR}/visudo/.local/bin/*
mkdir -p ~/.local/bin 

stow -v -t ~ -d $SCRIPT_DIR tmux kitty nvim visudo zsh atuin

echo "-----------------------------------------"
