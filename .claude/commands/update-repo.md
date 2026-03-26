Update the dotfiles repo: pull latest changes, reinstall brew packages, and verify everything works.

1. Run `git -C ~/.dotfiles pull` to get latest changes
2. Run `HOMEBREW_ACCEPT_EULA=Y brew bundle --file=~/.dotfiles/Brewfile` to install any new packages
3. Run `make lint` to verify shell scripts pass shellcheck
4. Report what changed and any errors encountered
