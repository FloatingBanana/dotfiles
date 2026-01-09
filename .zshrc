if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt complete_aliases
bindkey -v

# Aliases
alias dtf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias cfzf="fzf -m --ansi --preview='bat {}'"
alias gmfzf='git ls-files -dmo --deduplicate | fzf -m --ansi --preview="git diff -u --color=always {} | diff-so-fancy"'
alias rish="exec ~/.rish/rish"

# Paths
export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"
export KEYTIMEOUT=1

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
