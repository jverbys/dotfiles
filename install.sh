#!/bin/bash

DOTFILES_PATH="$PWD"
HOME_PATH="$HOME"

for DOTS_FILENAME in $(find $DOTFILES_PATH -type f -not -path "*.git/*" ! -name "install.sh"); do
    HOME_FILENAME=${DOTS_FILENAME/$DOTFILES_PATH/$HOME_PATH}

    mkdir -p $(dirname $HOME_FILENAME)

    if [ -f $HOME_FILENAME ]; then
        read -p "file at $HOME_FILENAME already exists, override? (y/N) " response

        if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
            rm $HOME_FILENAME
            ln -s $DOTS_FILENAME $HOME_FILENAME
        fi
    else
        ln -s $DOTS_FILENAME $HOME_FILENAME
    fi
done
