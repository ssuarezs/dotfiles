# 🎯 macOS: Canonical Tool-Agnostic Global Agent Instructions

## 💡 Convention

Global AI agent instructions live in one canonical, tool-agnostic file, `macos/ia/GLOBAL_AGENTS.md`, never named after a specific tool. Each tool's expected config path (e.g. `~/.claude/CLAUDE.md`) is a symlink pointing at it.

## 🏆 Benefits

- Adopting or switching a tool (opencode, Copilot, Codex, ...) means adding one more symlink, not duplicating the instructions.
- The instructions stay in a single reviewable place instead of scattered copies drifting apart across tools.

## 👀 Examples

### ✅ Good

```bash
ln -s "$PWD/macos/ia/GLOBAL_AGENTS.md" "$HOME/.claude/CLAUDE.md"
```

### ❌ Bad

Maintaining separate, hand-written instructions per tool (`~/.claude/CLAUDE.md`, `~/.opencode/AGENTS.md`, ...).

## 🔗 Related agreements

- [Symlink instead of copy](../symlink-over-copy.md)
- [Installation entry points](../install-entrypoints.md)
