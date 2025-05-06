echo "=== Starting installation of dotfiles ==="

echo "Applying stow for dotfiles..."
rm -rf ~/.zshrc ~/.config/atuin/ ~/.config/kitty
SCRIPT_DIR=$(dirname "$(realpath "$0")")
chmod +x ${SCRIPT_DIR}/visudo/.local/bin/*
mkdir -p ~/.local/bin 

for package in tmux kitty nvim visudo zsh atuin; do
    if [ -d "${SCRIPT_DIR}/${package}" ]; then
        echo "Stowing ${package}..."
        stow --adopt -v -t ~ -d $SCRIPT_DIR $package 
    else
        echo "Warning: Package ${package} not found in ${SCRIPT_DIR}"
    fi
    echo "-----------------------------------------"
done