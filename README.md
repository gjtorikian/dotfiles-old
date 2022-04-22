# Dotfiles

Your dotfiles are how you personalize your system. These are mine.

## Installation

```
git clone https://github.com/gjtorikian/dotfiles ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

## Components

There's a few special files in the hierarchy.

* _bin/_: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
* _Brewfile_: This is a list of applications for [Homebrew Cask](http://caskroom.io) to install: things like Chrome and 1Password. Might want to edit this file before running any initial setup.
* _topic/path.zsh_: Any file named path.zsh is loaded first and is expected to
  expected to setup `$PATH` or similar.
- _topic/*.zsh_: Any files ending in .zsh get loaded into your
  environment.
* _topic/\*.symlink_: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Thanks

* [@bswinnerton](https://www.github.com/bswinnerton)
* [@holman](https://www.github.com/holman)
* [@MikeMcQuaid](https://www.github.com/MikeMcQuaid)
