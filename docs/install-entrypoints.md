# 🎯 Dotfiles: Installation Entry Points

## 💡 Convention

Each OS has a fixed, explicit list of scripts to run after cloning, no build tool wrapper. macOS: `etc/scripts/generate-claude-symlinks.sh`, then `etc/scripts/install-macos.sh`. Windows: `etc/scripts/generate-claude-symlinks.ps1`.

## 🏆 Benefits

- One clear, ordered list of commands to bootstrap a new machine, kept in `AGENTS.md`.
- Works right after cloning, with no dependency on `make` or any other tool being present first.

## 👀 Examples

### ✅ Good

```bash
bash etc/scripts/generate-claude-symlinks.sh
bash etc/scripts/install-macos.sh
```

### ❌ Bad

```bash
make install
```

## 🔗 Related agreements

- [Symlink instead of copy](./symlink-over-copy.md)
