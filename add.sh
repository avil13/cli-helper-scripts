#!/bin/bash

# Reset # # # # # # # #
off='\033[0m'         # Text Reset
# Regular Colors
black='\033[0;30m'    # Black
red='\033[0;31m'      # Red
green='\033[0;32m'    # Green
yellow='\033[0;33m'   # Yellow
blue='\033[0;34m'     # Blue
purple='\033[0;35m'   # Purple
cyan='\033[0;36m'     # Cyan
white='\033[0;37m'    # White
# # # # # # # # # # # #


# 1) приветствие
# 2) путь до программы относительно текущей директории
# 3) название программы в CLI режиме
# 4) создаем ссылку

# 1:
echo -en "${green}Hello, lets create a new CLI helper command${off}\n"
# 2:
echo -en "${cyan}Enter path to the program by current folder (example: ./my-prog/my-prog.sh)${off}\n"
read -e item_program

# 3:
echo -en "${cyan}Enter CLI helper name (example: my-prog)${off}\n"
read item_helper

# 4:
ln -s ../$item_program bin/$item_helper

if [ $? -eq 0 ]; then
    echo -e "\t${green}OK"
else
    echo -e "\t${red}FAIL"
fi

echo -e "$off"
