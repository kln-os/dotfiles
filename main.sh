echo "=== Starting installation of dotfiles ==="

echo "Applying stow for dotfiles..."
SCRIPT_DIR=$(dirname "$(realpath "$0")")
chmod +x ${SCRIPT_DIR}/vm/.local/bin/*

stow -v -t ~ -d $SCRIPT_DIR tmux kitty nvim vm zsh

echo "-----------------------------------------"
