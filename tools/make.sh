#!/bin/bash

if [ ! -d src ]; then
	echo "Wrong current dir `pwd`, quitting..."
	exit 1
fi

if [ -z $1 ]; then
	echo "No target specified, quitting..."
	exit 1
fi

target="$1"
echo "Building for $target ..."

mkdir tmp
cp -r src tmp

cd tmp

case $target in
	mv2)
		mv manifests/manifest2.json manifest.json
		rm -r manifests;;
		# Other, compress, etc
	mv3)
                mv manifests/manifest3.json manifest.json
                rm -r manifests;;
                # Other, compress, etc
	mv3ff)
                mv manifests/manifest3FF.json manifest.json
                rm -r manifests;;
                # Other, compress, etc
	*)
		echo "Unknown target"
		echo "Valid targets: mv2, mv3, mv3ff"
		exit 1
esac

