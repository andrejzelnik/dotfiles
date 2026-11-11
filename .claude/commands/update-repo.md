Update the dotfiles repo: pull latest changes, sync brew packages, mise tools and zim modules, and verify everything works.

1. Run `make -C ~/.dotfiles update` (git pull, `brew bundle`, `mise install`, `zimfw install` / `update` / `upgrade`)
2. Run `make -C ~/.dotfiles lint` to verify shell scripts pass shellcheck
3. Run `brew outdated`, `mise outdated` and `zsh -i -c 'zimfw check'` and list anything still behind
4. Report what changed and any errors encountered
