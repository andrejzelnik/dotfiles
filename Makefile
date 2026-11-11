DOTFILES_DIR := $(CURDIR)
SCRIPTS      := install.sh link.sh macos.sh

.PHONY: install update link macos lint help

install: ## Full setup from scratch
	@zsh $(DOTFILES_DIR)/install.sh

update: ## Pull latest, then sync brew packages, mise tools and zim modules
	@git -C $(DOTFILES_DIR) pull
	@HOMEBREW_ACCEPT_EULA=Y brew bundle --file=$(DOTFILES_DIR)/Brewfile
	@mise install
	@zsh -c 'source ~/.zshrc 2>/dev/null && zimfw install && zimfw update && zimfw upgrade' \
		|| echo "warning: zim update failed; run 'zimfw install && zimfw update && zimfw upgrade' manually" >&2
	@echo "Updated."

link: ## Re-link dotfiles only
	@zsh $(DOTFILES_DIR)/link.sh
	@echo "Dotfiles linked."

macos: ## Apply macOS system defaults
	@zsh $(DOTFILES_DIR)/macos.sh

lint: ## Run shellcheck on all shell scripts
	@shellcheck -s bash -e SC1090,SC1091 $(SCRIPTS)
	@echo "All scripts pass shellcheck."

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'
