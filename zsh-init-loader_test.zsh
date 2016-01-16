#!/bin/zsh -y

export ZSH_INIT_DIR=$(dirname $0)/test-inits
SHUNIT_PARENT=$0
. $(dirname $0)/zsh-init-loader.plugin.zsh >/dev/null 2>&1

unset-env-vars() {
  printenv | egrep '^test_zsh_init_loader_.*=.*' | cut -d '=' -f 1 |\
    while read var; do
      unset var
    done
}

oneTimeSetUp() {
  unset-env-vars
}

oneTimeTearDown() {

}

test_init_loader_load_files_digit() {
  echo '* load files with digit'
  assertEquals "$(echo $test_zsh_init_loader_00)" "first"
}

test_init_loader_load_files_stdin() {
  echo '* load files with stdin'
  assertEquals "$(echo $test_zsh_init_loader_stdin)" ""
}

test_init_loader_load_files_digit_order() {
  echo '* load files with digit in the correct order'
  assertEquals "$(init-loader-load-files digit | tr -d '\n')" "0099"
}

test_init_loader_load_files_cygwin() {
  echo '* load files with "cygwin-"'
  assertEquals "$(init-loader-load-files cygwin | tr -d '\n')" "cygwin"
}

test_init_loader_load_files_linux() {
  echo '* load files with "linux-"'
  assertEquals "$(init-loader-load-files linux | tr -d '\n')" "linux"
}

test_init_loader_load_files_osx() {
  echo '* load files with "osx-"'
  assertEquals "$(init-loader-load-files osx | tr -d '\n')" "osx"
}

. ./shunit2/src/shunit2
