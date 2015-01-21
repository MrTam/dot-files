#!/usr/bin/env bash

mkdir backup 2> /dev/null
if [ $? -eq 0 ]; then
    echo created backup directory
fi

for file in .[0-9A-Za-z]*; do
    src="`pwd`/$file"
    dest="$HOME/$file"

    if [ -L $dest ]; then 
        echo "removing existing symlink $dest"
        rm $dest 2> /dev/null
    fi

    if [ -e $dest ]; then 
        echo "backing up existing file $dest -> backup/$file"
        mv $dest backup/$file 2> /dev/null
    fi

    echo "linking $src -> $dest"
    ln -s $src $dest 2> /dev/null
done

# Setup vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Run vundle update
vim +PluginInstall +qall

# Setup YCM
cd $HOME/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
