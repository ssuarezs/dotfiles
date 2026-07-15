# Purpose

Personal dotfiles, managed for two machines with different scopes:

- **macOS** (personal): full environment — shell, editor, terminal, apps, and setup for studying and side projects/pilots.
- **Windows** (work): minimal footprint — shell, git, and terminal only. See [docs/macos-windows-scope.md](docs/macos-windows-scope.md).

# Useful commands

```bash
make claude-symlinks # macOS: symlink AGENTS.md -> CLAUDE.md and .claude/skills -> .agents/skills across the repo
```

```powershell
./etc/scripts/generate-claude-symlinks.ps1 # Windows: same as above, run from an elevated PowerShell or with Developer Mode on
```

# Architecture

Config is applied to the home directory via symlinks, never copies — see [docs/symlink-over-copy.md](docs/symlink-over-copy.md).

- `macos/` — configuration only for the personal macOS machine.
- `windows/` — configuration only for the work Windows machine (kept minimal).
- `etc/scripts/` — install/symlink scripts.
- `docs/` — conventions and decisions behind this repo's setup.

# Documentation

- Detailed conventions with examples live in `docs/`.
- **Do NOT read all docs upfront.**
- When working on a task, use this map to find and read only the docs relevant to your task:

```
docs/
├── documentation-guidelines.md
├── symlink-over-copy.md
├── macos-windows-scope.md
├── commit-conventions.md
```
