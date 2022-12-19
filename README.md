# Dotfiles

Configuration files tracked with Git `--bare` repo.

---

## Table of Contents

- [Setup](#setup)
    - [Install Script](#install-script)
- [Usage](#usage)
- [Configurations](#configurations)
    - [Neovim](#neovim)

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
    alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    ```

    This is the alias that you'll use to handle your dotfiles (bare git) changes, which can be called from any directory, even from inside another git repo!

    ```sh
    # therefore, these commands:
    config status
    config push

    # are just git commands like below -- only that the `config`
    # command uses our `.dotfiles` bare repo as git context 
    git status
    git push
    ```
    

- Checkout the actual content from the bare repository to your `$HOME`:

    ```sh
    config checkout
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
    mkdir -p .config-backup && \
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}
    ```

- Re-run the check out if you had problems:

    ```sh
    config checkout
    ```

- Set the Git flag `showUntrackedFiles` to `no` on this specific (local) repository:

    ```sh
    config config --local status.showUntrackedFiles no
    ```

- You're done, from now on you can now type `config` commands to add and update your dotfiles

### Install Script
As a shortcut not to have to remember all these steps on any new machine you want to setup, you can create a simple script and store it as Bitbucket snippet:

```sh
curl -Lks https://github.com/ngtinsmith/dotfiles/blob/master/.bin/install.sh | /bin/bash
```


`install.sh`

```sh
#!/bin/bash

# prevent weird git repo recursion problems
echo ".dotfiles" >> .gitignore

git clone --bare git@github.com:ngtinsmith/dotfiles.git $HOME/.dotfiles

function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

config checkout

if [ $? = 0 ]; then
    echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    mkdir -p .config-backup
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout
config config --local status.showUntrackedFiles no
```

### Usage

```sh
# add new config
config status
config add .vimrc
config commit -m "add vimrc"

# add directory of configs / modules
config add ~/.config/nvim/init.lua
config add ~/.config/nvim/lua
config commit -m "add nvim init.lua and lua modules"

# push changes
config push
```

