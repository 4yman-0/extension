#!/bin/bash

# HELPER FUNCTIONS
fail (){
	echo "$1, quitting..."
	exit 1
}

stage (){
	echo "** $1 ..."
}

# PACKAGING FUNCTIONS
pkg_zip (){
	zip "../build/$1"  -r -9 -- * > /dev/null
}

pkg_ff (){
	pkg_zip extension.xpi
}

pkg_chrome (){
	pkg_zip extension.chrome.zip
}

# PROGRAM
if [ ! -d src ]; then
	fail "Wrong current dir $(pwd)"
fi

if [ -z "$1" ]; then
	fail "No target specified"
fi

target="$1"
stage "Build for $target"

stage "Create temporary directory"
rm -r tmp &> /dev/null
mkdir tmp

stage "Copy source code"
cp -r src/* tmp

cd tmp || exit 1

stage "Move platform-specific files"
mv "platform/$target/"* .
rm -r platform

stage "Package for browser"
case $target in
	# TODO: More platforms
	mv2)
		pkg_chrome;;
	mv3)
		pkg_chrome;;
	mv3ff)
		pkg_ff;;
	*)
		echo "Valid targets: mv2, mv3, mv3ff"
		fail "Unknown target"
esac

cd .. || exit 1
rm -r tmp
