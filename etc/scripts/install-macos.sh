#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_dir="$(cd "$script_dir/../.." && pwd)"

link() {
  local target="$1"
  local link_path="$2"

  if [[ -e "$link_path" || -L "$link_path" ]]; then
    if [[ "$(readlink "$link_path")" == "$target" ]]; then
      echo "Skipping $link_path (already linked)"
      return
    fi
    echo "Skipping $link_path (exists and is not the expected symlink)"
    return
  fi

  mkdir -p "$(dirname "$link_path")"
  ln -s "$target" "$link_path"
  echo "Created symlink $link_path → $target"
}

link "$project_dir/macos/ia/GLOBAL_AGENTS.md" "$HOME/.claude/CLAUDE.md"
