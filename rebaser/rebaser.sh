#!/bin/bash

# Reset # # # # # # # #
off='\033[0m'       # Text Reset
# Regular Colors
red='\033[0;31m'    # Red
green='\033[0;32m'  # Green
yellow='\033[0;33m' # Yellow
purple='\033[0;35m' # Purple
# # # # # # # # # # # #

PARENT=$(git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//')

function doRebaise() {
    # Спрашиываем стоит ли подтягивать изменения с сервера
    echo -e "Do pull from ${green}$1${off} (Y/n): "
    read answer

    if [ "$answer" == "${answer#[Nn]}" ]; then
        echo -e "Just rebase from ${green}$1${off}"
    else
        git checkout $1
        git pull
        git checkout -
    fi
    
    git rebase -i $1
}


if [ -z "$PARENT" ]; then
    # Родительской ветки нет поэтому тожем только от мастера
    echo -e "${yellow} Can't find parent branch. Do rebase from ${green}master${off} (Y/n): "
    read answer

    if [ "$answer" == "${answer#[Nn]}" ]; then
        echo -e "${purple} We didn't do anything... ${off}"
    else
        doRebaise "master"
    fi
else
    # Родительская ветка есть, ребейзимся на нее
    echo -e "――――――――――――――――――――――――――――――――――――――"
    echo -e " ${yellow}1${off}) ${green}${PARENT}${off} (parent branch)"
    echo -e " ${yellow}2${off}) ${green}master${off}"
    echo -e "――――――――――――――――――――――――――――――――――――――"

    read -p "Choose rebase branch number: " answer

    case ${answer:0:1} in
    1)
        doRebaise "$PARENT"
        ;;
    2)
        doRebaise "master"
        ;;
    *)
        echo -e "${red} The choice is made incorrectly ${off}"
        ;;
    esac
fi

