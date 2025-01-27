# Dotfiles

Configuration files tracked with Git `--bare` repo.

---

## Table of Contents

- [Setup](#setup)
    - [Install script](#install-script)
    - [Usage](#usage)

## Setup

Personalised configuration steps based on Atlassian's Guide - [Dotfiles: Best Way to Store in a Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles)

- Your source repository should ignore the folder where you'll clone it, so that you don't create weird recursion problems:

    ```sh
    echo ".dotfiles" >> .gitignore
    ```

- Now clone your dotfiles into a bare repository in a "dot" folder of your `$HOME`:

    ```sh
    git clone --bare <git-repo-url> $HOME/.dotfiles
    ```

- Define the alias in the current shell scope (OR add it to your `.aliases`, `.bashrc`, or `.zshrc` if you don't have it in your dotfiles-tracked-repo's shell aliases or rc files yet)

    ```sh
    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```

    This is the alias that you'll use to handle your dotfiles (bare git) changes, which can be called from any directory, even from inside another git repo!

    ```sh
    # therefore, these commands:
    dotfiles status
    dotfiles push

    # are just git commands like below; only that the `dotfiles`
    # command uses our `.dotfiles` bare repo as git context defined
    # by our alias
    git status
    git push
    ```
    

- Checkout the actual content from the bare repository to your `$HOME`:

    ```sh
    dotfiles checkout
    ```

- The step above might fail with a message like:

    ```sh
    error: The following untracked working tree files would be overwritten by checkout:
        .bashrc
        .gitignore
    Please move or remove them before you can switch branches.
    Aborting
    ```

    This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git.

    The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:

    ```sh
    mkdir -p .dotfiles-backup && \
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .dotfiles-backup/{}
    ```

- Re-run the check out if you had problems:

    ```sh
    dotfiles checkout
    ```

- Set the Git flag `showUntrackedFiles` to `no` on this specific (local) repository:

    ```sh
    dotfiles config --local status.showUntrackedFiles no
    ```

- You're done, from now on you can now type `dotfiles` commands to add and update your dotfiles

### Install script
As a shortcut not to have to remember all these steps on any new machine you want to setup, you can create a simple script and store it as Bitbucket snippet:

```sh
curl -o- https://raw.githubusercontent.com/ngtinsmith/dotfiles/macos/.bin/install.sh | bash
```


`install.sh`

```sh
#!/bin/bash

if [[ ! -s ~/.dotfiles ]]; then
    mkdir ~/.dotfiles
fi

# prevent weird git repo recursion problems
echo ".dotfiles" >> .gitignore

git clone --bare git@github.com:ngtinsmith/dotfiles.git $HOME/.dotfiles

function dotfiles {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dotfiles checkout

if [ $? = 0 ]; then
    echo "Checked out dotfiles config.";
  else
    echo "Backing up pre-existing dotfiles.";
    mkdir -p .dotfiles-backup
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

### Usage

```sh
# add new config
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "add vimrc"

# add directory of configs / modules
dotfiles add ~/.config/nvim/init.lua
dotfiles add ~/.config/nvim/lua
dotfiles commit -m "add nvim init.lua and lua modules"

# push changes
dotfiles push
```

