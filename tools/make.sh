#!/bin/bash

fail () {
	echo "$1, quitting..."
	exit 1
}

pkg_zip (){
	zip ../extension.zip -r * > /dev/null # Also move to repo root
}

if [ ! -d src ]; then
	fail "Wrong current dir `pwd`"
fi

if [ -z $1 ]; then
	fail "No target specified"
fi

target="$1"
echo "Building for $target ..."

mkdir tmp
cp -r src/* tmp

cd tmp


mv manifests/$target/* .
rm -r manifests

case $target in
	# To do: More platforms
	mv2)
		pkg_zip;;
	mv3)
		pkg_zip;;
	mv3ff)
		pkg_zip;;
	*)
		echo "Valid targets: mv2, mv3, mv3ff"
		fail "Unknown target"
esac

cd ..
rm -r tmp
