# 🎯 Git: Commit Conventions

## 💡 Convention

Every commit message follows the Conventional Commits format, `type(scope): description` in the imperative mood, and never includes an AI-authorship trailer (Claude, Copilot, Codex, or any other assistant).

Common types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `style`, `build`, `ci`, `perf`. Scope is optional and names the affected area (e.g. `macos`, `windows`, `docs`).

## 🏆 Benefits

- `git log` communicates the nature of every change without opening the diff.
- History stays consistent and scannable regardless of who or what typed the commit.
- Commit authorship stays accurate: the human who requested and reviewed the change, not the tool that typed it.

## 👀 Examples

### ✅ Good

```
feat(macos): add zsh aliases for git shortcuts
fix(windows): correct symlink target path in profile script
chore: scaffold dotfiles repo structure
```

### ❌ Bad

```
Added some stuff

Co-Authored-By: Claude <noreply@anthropic.com>
```

## 🔗 Related agreements

- [Documentation guidelines](./documentation-guidelines.md)
