##
## Commands
##

sync: ## Sync files
	[ -f ~/.gitconfig ] || ln -s $(PWD)/src/.gitconfig ~/.gitconfig
	[ -f ~/.vimrc ] || ln -s $(PWD)/src/.vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/src/.zshrc ~/.zshrc

clean: ## Delete files
	rm -f ~/.gitconfig
	rm -f ~/.vimrc
	rm -f ~/.zshrc

.PHONY: sync clean

##

.DEFAULT_GOAL := help
help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help

