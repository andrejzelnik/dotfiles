# Dotfiles

macOS (Apple Silicon) dotfiles repo. All configs live here and are symlinked to `$HOME` via `install.sh`.

## Structure

```
.zimrc              → ~/.zimrc              # Zim zsh framework modules
.zshrc              → ~/.zshrc              # Shell config, aliases, completions
.gitconfig          → ~/.gitconfig          # Git config (identity in ~/.gitconfig.local)
.gitignore_global   → ~/.gitignore_global   # Global gitignore
.tmux.conf          → ~/.tmux.conf          # Tmux config
.ssh/config         → ~/.ssh/config         # SSH config (local overrides in ~/.ssh/config.local)
.mise.toml          → ~/.config/mise/config.toml  # Language version manager
starship.toml       → ~/.config/starship.toml     # Prompt theme
vscode/             → VS Code User dir      # Editor settings + extensions list
macos.sh            # macOS system defaults (run once)
Brewfile            # All Homebrew packages and casks
```

## Conventions

- **Symlinks**: `install.sh` backs up existing files to `~/.dotfiles-backup/` before linking.
- **Local overrides**: `.gitconfig.local` and `.ssh/config.local` are included but not tracked.
- **Brewfile categories**: Terminal, Cloud & infrastructure, Data, Development, Fonts, Apps.
- **Completions**: Cached weekly in `~/.cache/zsh/` to avoid slow shell startup.
- **Shell scripts**: Must pass `shellcheck`. Pre-commit hook enforces this.

## Common tasks

- `make install` — full setup from scratch
- `make update` — pull latest + reinstall brew packages + zim modules
- `make link` — re-link dotfiles only
- `make macos` — apply macOS system defaults
- `make lint` — run shellcheck on all shell scripts
