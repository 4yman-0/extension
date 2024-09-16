#!/bin/bash

fail () {
	echo "$1, quitting..."
	exit 1
}

pkg_zip (){
	zip extension.zip -r -9 * > /dev/null
}

pkg_ff (){
	pkg_zip
	mv extension.zip extension.xpi
}

pkg_chrome (){
	pkg_zip
	mv extension.zip extension.crx
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
echo "Created temp dir ..."


mv platform/$target/* .
rm -r platform

case $target in
	# To do: More platforms
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

mv extension.{zip,xpi,crx} ../build

cd ..
rm -r tmp
