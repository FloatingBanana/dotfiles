(cat ~/.cache/wal/sequences &)

setopt complete_aliases

# Aliases
alias dtf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias v=nvim
alias cfzf="fzf -m --ansi --preview='bat {}'"
alias gmfzf='git ls-files -dmo --deduplicate | fzf -m --ansi --preview="git diff -u --color=always {} | diff-so-fancy"'
alias tb='nc termbin.com 9999'

export EDITOR='nvim'
export KEYTIMEOUT=1
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="flazz"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOQUIT="true"
ZSH_TMUX_AUTOCONNECT="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(
	git
	fzf
	tmux
)

source $ZSH/oh-my-zsh.sh
if [[ -z "$SSH_AUTO_SOCK" ]]; then
	eval "$(ssh-agent -s)" >> /dev/null
fi

bindkey -v
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
