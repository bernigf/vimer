#!/bin/bash

name="vimer"
version="0.0.5"

folder_main=".vim"
folder_colors="colors"

file_1_name="./vimrc"
file_1_dest="~/.vimrc"

file_2_name="./colors/nord.vim"
file_2_dest="~/$folder_main/$folder_colors/nord.vim"

file_3_name="./colors/afterglow.vim"
file_3_dest="~/$folder_main/$folder_colors/afterglow.vim"

echo ""
echo "$name installer v$version"
echo "======================"
echo ""
echo "Copying $name files.."
echo ""

echo "Creating ~/$folder_main"
eval "mkdir ~/$folder_main"

echo "Creating ~/$folder_main/$folder_colors"
eval "mkdir ~/$folder_main/$folder_colors"

# echo ""
#echo "Creating $name config files..."
#echo ""
#echo "Creating ~/$folder_main/$file_config"
#eval "touch ~/$folder_main/$file_config"
#echo "Creating ~/$folder_main/$file_history"
#eval "touch ~/$folder_main/$file_history"
#echo ""

echo "Copying $name files..."
echo ""

echo "Copying $file_1_name to $file_1_dest ..."
eval "cp $file_1_name $file_1_dest"

echo "Copying $file_2_name to $file_2_dest ..."
eval "cp $file_2_name $file_2_dest"

echo "Copying $file_3_name to $file_3_dest ..."
eval "cp $file_3_name $file_3_dest"

echo ""
echo "Installation finished"
echo ""

