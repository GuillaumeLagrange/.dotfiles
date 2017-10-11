cd ~
rm -rf .vim .vimrc .zshrc .config/i3 .config/i3status
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.zshrc .zshrc
ln -s .dotfiles/.config/i3 .config/i3
ln -s .dotfiles/.config/i3status .config/i3status
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
