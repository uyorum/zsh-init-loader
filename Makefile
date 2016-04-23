.PHONY: test

SHUNIT_VER ?= 2.1.6

all: shunit2 test

shunit2:
	wget http://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/shunit2/shunit2-${SHUNIT_VER}.tgz
	tar zxvf shunit2-${SHUNIT_VER}.tgz
	mv shunit2-${SHUNIT_VER} shunit2
	rm -rf shunit2-${SHUNIT_VER}.tgz

test:
	zsh -o shwordsplit zsh-init-loader_test.zsh
