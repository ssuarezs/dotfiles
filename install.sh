#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

cli_tools=(
  git
  gh
  tree-sitter-cli
  curl
  gnu-tar
  ripgrep
  fd
  lazygit
  git-delta
  zoxide
  tmux
)

terminal_tools=(
  jandedobbeleer/oh-my-posh/oh-my-posh
  eza
  bat
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

linux_only_tools=(
  zsh
)

macos_apps=(
  ghostty
  docker-desktop
  karabiner-elements
  raycast
)

macos_fonts=(
  font-plemol-jp-nf
  font-iosevka-term-nerd-font
)

is_macos() { [[ "$OS" == "Darwin" ]]; }
is_linux() { [[ "$OS" == "Linux" ]]; }

load_brew() {
  local brew_bin
  for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew \
                  /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
    if [[ -x "$brew_bin" ]]; then
      eval "$("$brew_bin" shellenv)"
      return
    fi
  done
  echo "Homebrew is not installed. See step 0 (Prerequisites)." >&2
  exit 1
}

install_formulae() {
  local formula
  for formula in "$@"; do
    if brew list --formula "$formula" >/dev/null 2>&1; then
      echo "✓ $formula (already installed)"
    else
      brew install --formula "$formula"
    fi
  done
}

install_casks() {
  local cask
  for cask in "$@"; do
    if brew list --cask "$cask" >/dev/null 2>&1; then
      echo "✓ $cask (already installed)"
    else
      brew install --cask "$cask"
    fi
  done
}

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "✓ oh-my-zsh (already installed)"
    return
  fi
  RUNZSH=no KEEP_ZSHRC=yes CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

install_tmux_plugins() {
  local tpm_dir="$HOME/.local/share/tmux/plugins/tpm"
  if [[ ! -d "$tpm_dir" ]]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
  fi
  "$tpm_dir/bin/install_plugins"
}

link_with_backup() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
    echo "  backed up existing $dest"
  fi
  ln -sfn "$src" "$dest"
  echo "✓ $dest -> $src"
}

remove_legacy_tmux_conf() {
  if [[ -L "$HOME/.tmux.conf" ]]; then
    rm "$HOME/.tmux.conf"
    echo "✓ removed legacy ~/.tmux.conf symlink"
  fi
}

list_insecure_completion_dirs() {
  local brew_prefix
  brew_prefix="$(brew --prefix)"
  zsh -c "autoload -Uz compaudit
    FPATH='$brew_prefix/share/zsh-completions:$brew_prefix/share/zsh/site-functions':\$FPATH
    compaudit" 2>/dev/null || true
}

fix_insecure_completion_dirs() {
  local insecure_dirs dir
  insecure_dirs="$(list_insecure_completion_dirs)"
  if [[ -z "$insecure_dirs" ]]; then
    echo "✓ no insecure directories"
    return
  fi
  while IFS= read -r dir; do
    [[ -n "$dir" ]] || continue
    chmod go-w "$dir"
    echo "✓ removed group/other write from $dir"
  done <<< "$insecure_dirs"
  rm -f "$HOME"/.zcompdump*
}

load_brew
brew update

echo "==> CLI tools"
install_formulae "${cli_tools[@]}"

echo "==> Terminal tools"
install_formulae "${terminal_tools[@]}"
if is_linux; then
  install_formulae "${linux_only_tools[@]}"
fi

if is_macos; then
  echo "==> macOS GUI apps"
  install_casks "${macos_apps[@]}"

  echo "==> macOS fonts"
  install_casks "${macos_fonts[@]}"
fi

echo "==> Oh My Zsh"
install_oh_my_zsh

echo "==> Symlinks"
link_with_backup "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_with_backup "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
remove_legacy_tmux_conf
link_with_backup "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
link_with_backup "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_with_backup "$DOTFILES_DIR/lazygit" "$HOME/.config/lazygit"
if is_macos; then
  link_with_backup "$DOTFILES_DIR/karabiner" "$HOME/.config/karabiner"
fi

echo "==> tmux plugins"
install_tmux_plugins

echo "==> Completion directories"
fix_insecure_completion_dirs

if is_macos; then
  echo "==> macOS defaults"
  bash "$DOTFILES_DIR/macos/defaults.sh"
fi

echo "Done."
