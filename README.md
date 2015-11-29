# zsh-init-loader
## What is it?
zsh-init-loader is a loader of configuration files in zsh which is inspired by `init-loader`([emacs-jp/nit-loader](https://github.com/emacs-jp/init-loader)).

## Usage
Download repository and load zsh-init-loader.plugin.zsh in your .zshrc.

```bash
source /path/to/zsh-init-loader.plugin.zsh
```

Or you can use [antigen](https://github.com/zsh-users/antigen) to download and load this.

```bash
antigen bundle uyorum/zsh-init-loader
```

## Configuration files
Configuration files named properly in `$HOME/.zsh/inits`.
They must start with two digits or platform name and end with zsh.

### Two digits
Files which start with two digits and underscore.
They are loaded in order.

* 00_key-bindings.zsh
* 01_aliases.zsh
* 10_foo.zsh
* 99_bar.zsh

### Platform name
Files which start with platform name and hyphen.
In addition to two-digit files, these files are loaded depending on platform.
This supports following platforms.

|Platform|Prefix|Example|
|--------|------|-------|
|Cygwin(Windows)|cygwin-|cygwin-functions.zsh|
|OS X|osx-|osx-commands.zsh|
|Linux|linux-|linux-key.zsh|

## Customization
### `ZSH_INIT_DIR`
Directory of configuration files. (default: "`$HOME/.zsh/inits`")  

```bash
export ZSH_INIT_DIR=/path/to/dir
source /path/to/zsh-init-loader.plugin.zsh
```
