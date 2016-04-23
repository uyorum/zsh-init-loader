readonly REGEXP_DIGIT='.*\/[0-9][0-9]_.*\.zsh'
readonly REGEXP_OSX='.*\/osx-.*\.zsh'
readonly REGEXP_LINUX='.*\/linux-.*\.zsh'
readonly REGEXP_CYGWIN='.*\/cygwin-.*\.zsh'

__set_default () {
  local arg_name="$1"
  local arg_value="$2"
  eval "test -z \"\$$arg_name\" && export $arg_name='$arg_value'"
}

__set_default ZSH_INIT_DIR $HOME/.zsh/inits
unfunction -- __set_default

zsh_init_load_files() {
  for config_file in $(find "${ZSH_INIT_DIR}" -type f -follow -regex "$1" | sort); do
    source $config_file
  done
}

zsh_init_load_digit() {
  zsh_init_load_files "${REGEXP_DIGIT}"
}

zsh_init_load_platform() {
  case $(uname) in
    'Darwin')
      zsh_init_load_files "${REGEXP_OSX}"
      ;;
    'Linux')
      zsh_init_load_files "${REGEXP_LINUX}"
      ;;
    CYGWIN_NT*)
      zsh_init_load_files "${REGEXP_CYGWIN}"
      ;;
    *)
      ;;
  esac
}

zsh_init_load_digit
zsh_init_load_platform
