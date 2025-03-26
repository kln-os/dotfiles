# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH="$PATH:$HOME/.local/bin"
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
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
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
alias cd='z'
alias f=fzf
alias fp='fzf --preview="batcat --color=always {}"'
alias cat='batcat --paging=never --plain'
alias ls='eza --icons --group-directories-first'
alias v=nvim
alias vf='nvim $(fzf -m --preview="batcat --color=always {}")'
alias vcf='cd ~/.config/nvim && nvim'
alias vz='nvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias spy='source .venv/bin/activate'
alias cc='conda create -p ./.venv python==3.12'
alias ca='conda activate ./.venv'
alias gcg='git config --global user.name khanhkhanhlele && git config --global user.email namkhanh2172@gmail.com'
alias gcl='git config --local user.name khanhkhanhlele && git config --local user.email namkhanh2172@gmail.com'
alias gu='git pull && git add . && git commit -m "update" && git push'
alias hypr='xmodmap ~/.Xmodmap'
