# .dotfiles

This is a collection of my dotfiles.

## Usage

Clone this repository to your home directory (`~/.dotfiles`), then run `stow` to symlink the dotfiles you want to use.

For example, to symlink the `vim` dotfiles, run:

```shell
cd ~/.dotfiles
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
