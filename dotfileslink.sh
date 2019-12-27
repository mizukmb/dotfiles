#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
ln -sf $SCRIPT_DIR/.vimrc ~/.vimrc
ln -sf $SCRIPT_DIR/dein.toml ~/.dein.toml
ln -sf $SCRIPT_DIR/.gvimrc ~/.gvimrc
ln -sf $SCRIPT_DIR/.vimshrc ~/.vimshrc
ln -sf $SCRIPT_DIR/.zshrc ~/.zshrc
ln -sf $SCRIPT_DIR/.gitignore ~/.gitignore
ln -sf $SCRIPT_DIR/.tmux.conf ~/.tmux.conf
