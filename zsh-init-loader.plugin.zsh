regexp_digit='.*\/[0-9]{2}_.*\.(zsh|sh)'
regexp_osx='.*\/osx-.*\.(zsh|sh)'
regexp_linux='.*\/linux-.*\.(zsh|sh)'
regexp_cygwin='.*\/cygwin-.*\.(zsh|sh)'

-set-default () {
  local arg_name="$1"
  local arg_value="$2"
  eval "test -z \"\$$arg_name\" && export $arg_name='$arg_value'"
}

# configuration files directory
-set-default ZSH_INIT_DIR $HOME/.zsh/inits
unfunction -- -set-default

find-files() {
  find "$ZSH_INIT_DIR" -type f -regextype posix-awk -regex "$1" | sort
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
  find-files-$1 | while read config_file; do
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
