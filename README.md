# dotfiles

Personal dotfiles for two machines:

- **macOS** — full environment.
- **Windows** — minimal: shell, git, terminal.

## Install

### Repo agent config symlinks

```bash
bash etc/scripts/generate-claude-symlinks.sh # macOS
```

```powershell
./etc/scripts/generate-claude-symlinks.ps1 # Windows
```

### Dotfiles install

```bash
bash etc/scripts/install-macos.sh # macOS
```

## Structure

- `macos/` — macOS-only config.
- `windows/` — Windows-only config.
- `etc/scripts/` — install/symlink scripts.
- `docs/` — conventions and decisions behind this setup.

## Documentation

Conventions and decisions live in `docs/`. See `AGENTS.md` for the full map.

## License

[MIT](LICENSE)
