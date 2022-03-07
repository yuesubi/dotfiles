#!/bin/bash

if [ $1 ]; then
	home_dir=${1}
else
	home_dir=~
fi

########## Variables

dir=$home_dir/dotfiles                    # dotfiles directory
olddir=${dir}/old             # old dotfiles backup directory

# list of files/folders to symlink in homedir
files=".bashrc .xinitrc .config/picom .config/qtile"
files="$files .config/alacritty .config/fish .config/xinits"
files="$files .config/htop .config/gtk-2.0 .config/gtk-3.0"
files="$files .config/dmscripts .config/awesome startwm.sh"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ ! -e $dir/$file ]; then
        parentdir=$(dirname $dir/$file)
        echo "Making directory $parentdir"
        mkdir -p $parentdir

        echo "Adding $file to $dir"
        mv $home_dir/$file $dir/$file
    fi

    parentdir=$(dirname ~/$file)
    echo "Making directory $parentdir"
    mkdir -p $parentdir

    parentdir=$(dirname $olddir/$file)
    echo "Making directory $parentdir"
    mkdir -p $parentdir

    if [ ! -e ~/$file ]; then
        echo "Moving any existing dotfiles from ~ to $olddir"
        mv $home_dir/$file $olddir/$file
    fi
    
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file $home_dir/$file
done
