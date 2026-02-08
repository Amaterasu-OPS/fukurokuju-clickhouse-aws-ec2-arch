CLEAN ?= 1
TERRAGRUNT := terragrunt
TERRAGRUNT_FLAGS := run --all --non-interactive

CACHE_DIRS := .terragrunt-cache .terraform .terraform.lock.hcl

.PHONY: help
help:
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: init
init:
	$(TERRAGRUNT) $(TERRAGRUNT_FLAGS) init

.PHONY: plan
plan:
	$(TERRAGRUNT) $(TERRAGRUNT_FLAGS) plan
	@$(MAKE) --no-print-directory clean-if-enabled

.PHONY: apply
apply:
	$(TERRAGRUNT) $(TERRAGRUNT_FLAGS) apply
	@$(MAKE) --no-print-directory clean-if-enabled

.PHONY: destroy
destroy:
	$(TERRAGRUNT) $(TERRAGRUNT_FLAGS) destroy
	@$(MAKE) --no-print-directory clean-if-enabled

.PHONY: validate
validate: ## Validate terragrunt configuration
	$(TERRAGRUNT) $(TERRAGRUNT_FLAGS) validate

.PHONY: fmt
fmt:
	$(TERRAGRUNT) hclfmt

.PHONY: clean-cache
clean-cache:
	@echo "Cleaning cache directories..."
	@find . -type d -name ".terragrunt-cache" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	@echo "Cache cleaned successfully"

.PHONY: clean-if-enabled
clean-if-enabled:
	@if [ "$(CLEAN)" -eq 1 ]; then \
		$(MAKE) --no-print-directory clean-cache; \
	fi

.DEFAULT_GOAL := help