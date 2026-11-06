brew_candidates=(
  /opt/homebrew/bin/brew
  /usr/local/bin/brew
  /home/linuxbrew/.linuxbrew/bin/brew
  "$HOME/.linuxbrew/bin/brew"
)
for brew_bin in $brew_candidates; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done
unset brew_candidates brew_bin

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export XDG_CONFIG_HOME="$HOME/.config"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(
  git
  sudo
  docker
  web-search
  history
)
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]] && command -v oh-my-posh >/dev/null; then
  eval "$(oh-my-posh init zsh --config "$(brew --prefix oh-my-posh)/themes/amro.omp.json")"
fi

if command -v brew >/dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  FPATH="$BREW_PREFIX/share/zsh-completions:$BREW_PREFIX/share/zsh/site-functions:$FPATH"

  autoload -Uz compinit
  compinit

  [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -a --icons"
alias lla="eza -la --icons"
alias cat="bat"
alias cd="z"
alias ..="cd .."
alias ...="cd ../.."
alias g="git"
alias v="nvim"
alias dcu="docker compose up -d"
alias dcub="docker compose up -d --build"
alias dcd="docker compose down -v"
alias cc="claude"
alias oc="opencode"
alias tx="tmux"
alias reload="source ~/.zshrc"

[[ -o interactive ]] && clear
