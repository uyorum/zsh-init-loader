#!/usr/bin/env zsh

SHUNIT_PARENT=$0

export ZSH_INIT_DIR_ORG=$(dirname $0)/test-inits
export ZSH_INIT_DIR_LN=${ZSH_INIT_DIR_ORG}-ln
ZSH_INIT_DIR=${ZSH_INIT_DIR_ORG} . $(dirname $0)/zsh-init-loader.plugin.zsh

unset_vars() {
  for var in $(printenv | grep -o '^test_zsh_init_load[^=]*'); do
    unset $var
  done
  unset ZSH_INIT_DIR
}

oneTimeSetUp() {
  unset_vars
  ln -s "${ZSH_INIT_DIR_ORG}" "${ZSH_INIT_DIR_LN}"
}

oneTimeTearDown() {
  rm "${ZSH_INIT_DIR_LN}"
  unset_vars
  unset ZSH_INIT_DIR_ORG
  unset ZSH_INIT_DIR_LN
}

test_zsh_init_load_files() {
  unset_vars

  echo '* symlinked ZSH_INIT_DIR'
  ZSH_INIT_DIR=${ZSH_INIT_DIR_LN} zsh_init_load_files '.*\/00_.*\.zsh'
  assertEquals "$(echo $test_zsh_init_load_ln)" "loaded"

  echo '* load file which uses stdin'
  ZSH_INIT_DIR=${ZSH_INIT_DIR_LN} zsh_init_load_files '.*\/.*stdin\.zsh'
  assertEquals "$(echo $test_zsh_init_load_stdin)" "loaded"

}

test_zsh_init_load_digit() {
  unset_vars
  ZSH_INIT_DIR=${ZSH_INIT_DIR_ORG} zsh_init_load_digit

  echo '* load file with 00_'
  assertEquals "$(echo $test_zsh_init_load_00)" "loaded"

  echo '* load file with 99_'
  assertEquals "$(echo $test_zsh_init_load_99)" "loaded"

  echo '* load files with digit with correct order'
  assertEquals "$(echo $test_zsh_init_load_digit)" "0099"
}

test_zsh_init_load_platform() {

  echo '* load file with linux-'
  alias uname='echo Linux'
  unset_vars
  ZSH_INIT_DIR=${ZSH_INIT_DIR_ORG} zsh_init_load_platform
  assertEquals "$(echo $test_zsh_init_load_platform)" "linux"

  echo '* load file with cygwin-'
  alias uname='echo CYGWIN_NT-10.0'
  unset_vars
  ZSH_INIT_DIR=${ZSH_INIT_DIR_ORG} zsh_init_load_platform
  assertEquals "$(echo $test_zsh_init_load_platform)" "cygwin"

  echo '* load file with osx-'
  alias uname='echo Darwin'
  unset_vars
  ZSH_INIT_DIR=${ZSH_INIT_DIR_ORG} zsh_init_load_platform
  assertEquals "$(echo $test_zsh_init_load_platform)" "osx"
}

. ./shunit2/src/shunit2
