#!/bin/bash

echo

# Checks to make to ensure the current directory is a project folder
echo "Checking project..."

echo

Files[1]="index.html"
Files[2]="package.json"
Files[3]="Vagrantfile"
Files[4]="bootstrap.sh"
Files[5]="wordpress.sh"

for index in 1 2 3 4 5    # Five lines.
do
	if [[ ! -f "${Files[index]}" ]]; then
		echo "     Cannot locate ${Files[index]}, are you sure this is a webpack-bsd project?"
		echo "     Make sure you run this script from the root level of a project directory."
		echo
		exit 0
	fi
done

echo "Downloading latest version of webpack-bsd..."
mkdir -p .upgrade/
cd .upgrade
curl -sL https://github.com/blacksheepdesign/webpack-bsd/archive/master.tar.gz | tar xz

cd ..
rm -rf .upgrade/

echo

exit 0