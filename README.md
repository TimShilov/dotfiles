# My personal dotfiles
This is a collection of my dotfiles.

> [!NOTE]
> This doc is out of date and needs to be rewritten. The repo is now using Nix-Darwin and Home Manager instead of GNU Stow.

## Usage

Clone this repository to your home directory (`~/dotfiles`), then run `stow` to symlink the dotfiles you want to use.

For example, to symlink the `vim` dotfiles, run:

```shell
cd ~/dotfiles
stow zsh
```

## Brew usage

```shell
cd brew

# install everything
brew bundle

# update Brewfile
brew bundle dump

# Remove what's not listed in Brewfile
brew bundle cleanup
```

## Requirements

- [GNU Stow](https://www.gnu.org/software/stow/)
