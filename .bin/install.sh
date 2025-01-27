#!/bin/sh

if [[ ! -s ~/.dotfiles ]]; then
    mkdir "~/.dotfiles"
fi

# prevent weird git repo recursion problems
echo ".dotfiles" >> ".gitignore"

git clone --bare git@github.com:ngtinsmith/dotfiles.git "$HOME"/.dotfiles

dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

dotfiles checkout

if [ $? = 0 ]; then
    echo "Checked out dotfiles config.";
else
    echo "Backing up pre-existing dotfiles.";
    mkdir -p ".dotfiles-backup"
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
