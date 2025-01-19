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
	echo "To: $out"
	zip "../$out" -r -9 -- * > /dev/null
}

pkg_ff (){
	pkg_zip
}

pkg_chromium (){
	pkg_zip
}

# PROGRAM
if [ ! -d src ]; then
	fail "Wrong current dir $(pwd)"
fi

target="$1"
out="$2"

if [ -z "$target" ]; then
	fail "No target specified"
fi

if [ -z "$out" ]; then
	out="build/extension.zip"
fi

stage "Copy source code"
if [ ! -d build ];then 
	mkdir build
fi

cp -r src tmp
cd tmp || exit 1

stage "Move platform-specific files"
mv "platform/$target/"* .
rm -r platform

stage "Package for browser"
case $target in
	# TODO: More platforms
	mv2)
		pkg_chromium;;
	mv3)
		pkg_chromium;;
	mv3ff)
		pkg_ff;;
	*)
		echo "Valid targets: mv2, mv3, mv3ff"
		fail "Unknown target"
esac

cd .. || exit 1
rm -r tmp
