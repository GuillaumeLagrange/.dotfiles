./generate_i3_config.sh
cd ~
rm -rf .vim .vimrc .zshrc .config/i3status scripts
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/i3status ~/.config/i3status
ln -s ~/.dotfiles/scripts ~/scripts
ln -s ~/.dotfiles/.Xmodmap ~/.Xmodmap
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
