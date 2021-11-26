#!/bin/bash

DOTFILES_PATH="$PWD"
HOME_PATH="$HOME"

DOTFILES=$(find $DOTFILES_PATH -type f -not -path "*.git/*" ! -name "install.sh")

for DOTS_FILENAME in $DOTFILES; do
    HOME_FILENAME=${DOTS_FILENAME/$DOTFILES_PATH/$HOME_PATH}
    
    if [ -f $HOME_FILENAME ] || [ -h $HOME_FILENAME ]; then
        EXISTING_FILES="$EXISTING_FILES\n$HOME_FILENAME"
    fi
done

if [ ! -z $EXISTING_FILES ]; then
    echo -e "You have existing files in:\n$EXISTING_FILES\n"
    read -p "Do you want to override? (y/N) " RESPONSE
    
    if [ -z $RESPONSE ] || ([ $RESPONSE != "y" ] && [ $RESPONSE != "Y" ]); then
        exit
    fi
fi

for DOTS_FILENAME in $DOTFILES; do
    HOME_FILENAME=${DOTS_FILENAME/$DOTFILES_PATH/$HOME_PATH}
    
    mkdir -p $(dirname $HOME_FILENAME)
    
    if [ -f $HOME_FILENAME ] || [ -h $HOME_FILENAME ]; then
        rm $HOME_FILENAME
    fi
    
    ln -s $DOTS_FILENAME $HOME_FILENAME
done
