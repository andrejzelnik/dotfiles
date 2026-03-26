DOTFILES_DIR := $(shell pwd)

.PHONY: install update link macos lint

install: ## Full setup from scratch
	@zsh $(DOTFILES_DIR)/install.sh

update: ## Pull latest changes and reinstall
	@git -C $(DOTFILES_DIR) pull
	@HOMEBREW_ACCEPT_EULA=Y brew bundle --file=$(DOTFILES_DIR)/Brewfile
	@zsh -c 'source ~/.zshrc 2>/dev/null && zimfw install' || true
	@echo "Updated."

link: ## Re-link dotfiles only
	@zsh -c 'source $(DOTFILES_DIR)/install.sh 2>/dev/null || true'
	@echo "Use install.sh directly for full linking — this is a convenience alias."

macos: ## Apply macOS system defaults
	@zsh $(DOTFILES_DIR)/macos.sh

lint: ## Run shellcheck on all shell scripts
	@shellcheck -s bash -e SC1090,SC1091 install.sh macos.sh
	@echo "All scripts pass shellcheck."

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F ':.*## ' '{printf "  %-12s %s\n", $$1, $$2}'
