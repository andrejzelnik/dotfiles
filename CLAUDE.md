---
model: claude-sonnet-4-6
---

# Dotfiles

macOS (Apple Silicon) dotfiles symlinked to `$HOME` via `install.sh`.

## Structure

- `.zimrc` `.zshrc` `.gitconfig` `.gitignore_global` `.tmux.conf` `.ssh/config` → `~/` equivalents
- `.mise.toml` → `~/.config/mise/config.toml`, `starship.toml` → `~/.config/starship.toml`
- `vscode/` → VS Code User dir, `macos.sh` → system defaults, `Brewfile` → Homebrew packages

## Conventions

- `install.sh` backs up to `~/.dotfiles-backup/` before linking
- `.gitconfig.local` and `.ssh/config.local` for untracked local overrides
- Shell scripts must pass `shellcheck` (pre-commit hook)

## Tasks

`make install` | `make update` | `make link` | `make macos` | `make lint`
