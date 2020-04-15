sync:
	[ -f ~/.gitconfig ] || ln -s $(PWD)/src/.gitconfig ~/.gitconfig
	[ -f ~/.vimrc ] || ln -s $(PWD)/src/.vimrc ~/.vimrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/src/.zshrc ~/.zshrc

clean:
	rm -f ~/.gitconfig
	rm -f ~/.vimrc
	rm -f ~/.zshrc

.PHONY: sync clean
