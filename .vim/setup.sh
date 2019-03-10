set -x
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/Conf/.vim/vimrc ~/.vimrc
ln -s ~/Conf/.vim/vimrc.bundles ~/.vimrc.bundles
ln -s ~/Conf/.tmux.conf ~/.tmux.conf
vim +PluginInstall +qall
