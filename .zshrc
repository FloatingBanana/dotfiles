if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt complete_aliases

# Aliases
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Paths
export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOQUIT="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(
	git
	fzf
	tmux
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -z "$SSH_AUTO_SOCK" ]]; then
	eval "$(ssh-agent -s)" >> /dev/null
fi
