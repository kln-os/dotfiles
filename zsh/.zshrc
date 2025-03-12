# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:/home/kln/.local/bin"
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kln/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kln/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kln/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kln/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup


eval "$(zoxide init zsh)"
source $ZSH/oh-my-zsh.sh

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias cat="batcat --paging=never"
alias ls='eza --icons --group-directories-first'
# Created by `pipx` on 2025-02-25 09:53:24

eval $(thefuck --alias)
alias fk='fuck'

alias v=nvim
alias vim=nvim
alias nv=nvim
alias ovim=vim
alias oc='cd ~/Documents/git && echo "Went to the git folder"'
alias os='nvim ~/.zshrc'
alias ss='source ~/.zshrc'
alias vcf='cd ~/.config/nvim && nvim'
