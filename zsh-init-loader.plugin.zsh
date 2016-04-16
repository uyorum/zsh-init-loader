regexp_digit='.*\/[0-9][0-9]_.*\.zsh'
regexp_osx='.*\/osx-.*\.zsh'
regexp_linux='.*\/linux-.*\.zsh'
regexp_cygwin='.*\/cygwin-.*\.zsh'

-set-default () {
  local arg_name="$1"
  local arg_value="$2"
  eval "test -z \"\$$arg_name\" && export $arg_name='$arg_value'"
}

# configuration files directory
-set-default ZSH_INIT_DIR $HOME/.zsh/inits
unfunction -- -set-default

find-files() {
  find "$ZSH_INIT_DIR" -type f -follow -regex "$1" | sort
}

find-files-digit() {
  find-files "$regexp_digit"
}

find-files-cygwin() {
  find-files "$regexp_cygwin"
}

find-files-linux() {
  find-files "$regexp_linux"
}

find-files-osx() {
  find-files "$regexp_osx"
}

init-loader-load-files() {
  for config_file in `find-files-$1`; do # | while read config_file; do
    source $config_file
  done
}

# load configuration files
init-loader-load-files digit

case `uname` in
  Darwin)
    init-loader-load-files osx
    ;;
  Linux)
    init-loader-load-files linux
    ;;
  CYGWIN_NT*)
    init-loader-load-files cygwin
    ;;
  *)
    ;;
esac
