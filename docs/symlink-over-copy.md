# 🎯 Dotfiles: Symlink Instead of Copy

## 💡 Convention

Config files are applied to the home directory via symlinks pointing back into this repo, never by copying them. This applies on both machines: `ln -s` on macOS, `New-Item -ItemType SymbolicLink` (PowerShell) on Windows.

## 🏆 Benefits

- Editing the live config (e.g. `~/.zshrc` or the PowerShell `$PROFILE`) edits the tracked file directly, no manual re-sync step.
- `git status` in this repo immediately reflects changes made through the running shell or editor.
- Removing a config is a single delete of the symlink; the repo file stays untouched as the source of truth.

## 👀 Examples

### ✅ Good: linking a config file (macOS)

```bash
ln -s "$PWD/macos/zsh/.zshrc" "$HOME/.zshrc"
```

### ✅ Good: linking a config file (Windows)

```powershell
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$PWD\windows\powershell\profile.ps1"
```

### ❌ Bad: copying a config file

```bash
cp "$PWD/macos/zsh/.zshrc" "$HOME/.zshrc"
```

```powershell
Copy-Item "$PWD\windows\powershell\profile.ps1" -Destination $PROFILE
```

## ☝️ Exceptional cases: When to not take into account this convention

- Files that must hold machine-specific secrets or paths (e.g. a local git `includeIf` block) are generated from a template instead of symlinked, so they can diverge from the tracked version without any mid-file `.gitignore` tricks.
- Creating a symlink on Windows requires Developer Mode enabled or an elevated (Administrator) PowerShell session; the install script should check for this and fail with a clear message instead of silently falling back to a copy.

## 🔗 Related agreements

- [macOS vs Windows scope](./macos-windows-scope.md)
