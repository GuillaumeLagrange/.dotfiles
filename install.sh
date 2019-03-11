./generate_i3_config.sh
cd ~
rm -rf .vim .vimrc .zshrc .config/i3status
ln -s ~/.dotfiles/.vimrc .vimrc
ln -s ~/.dotfiles/.zshrc .zshrc
ln -s ~/.dotfiles/i3status ~/.config/i3status
ln -s ~/.dotfiles/.config/i3status ~/.config/i3status
ln -s ~/.dotfiles/scripts scripts
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
