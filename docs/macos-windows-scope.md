# 🎯 Dotfiles: Split Configuration Scope by Machine Role

## 💡 Convention

macOS (personal machine) tracks the full environment; Windows (work machine) tracks only shell, git, and terminal config.

## 🏆 Benefits

- Keeps the work machine's footprint small and easy to justify on company hardware.
- Avoids leaking personal-project tooling (studying, side projects, pilots) into a company-owned machine.
- macOS stays the place for experimentation without needing to keep Windows in sync.

## 👀 Examples

### ✅ Good: adding a new tool config

A personal CLI alias only needed for side projects goes under `macos/`.

### ❌ Bad: adding a new tool config

Adding a personal project's tool config under `windows/` when it isn't needed for work.

## ☝️ Exceptional cases: When to not take into account this convention

If a tool becomes required for actual work on the Windows machine (e.g. a linter used company-wide), add its config under `windows/` even if it falls outside shell/git/terminal.

## 🔗 Related agreements

- [Symlink instead of copy](./symlink-over-copy.md)
