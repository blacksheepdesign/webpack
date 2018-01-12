#!/bin/bash

echo

################
# Checks to make to ensure the current directory is a project folder
################
echo "# Checking project ..."

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

################
# Backup project
################
echo "# Creating backup of project ..."
UNIQDATE=`date +%s`

mkdir -p "/tmp/.webpack-bsd-backup-$UNIQDATE/"
rsync -r --filter=':- .gitignore' "./" "/tmp/.webpack-bsd-backup-$UNIQDATE/"
mv "/tmp/.webpack-bsd-backup-$UNIQDATE" ".backup"
echo

################
# Download template from Github
################
echo "# Downloading latest version of webpack-bsd ..."
mkdir -p .upgrade/
cd .upgrade
curl -sL https://github.com/blacksheepdesign/webpack-bsd/archive/master.tar.gz | tar xz
cd ..
echo

################
# Replace files with new versions
################
echo "# Running install script ..."
echo "# ========================"
echo

# Get project details
PACKAGE_NAME=$(cat package.json \
  | grep name \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')
PACKAGE_DESCRIPTION=$(cat package.json \
  | grep description \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')
PACKAGE_AUTHOR=$(cat package.json \
  | grep author \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g')
if grep -q lint package.json; then
	PACKAGE_LINT=true
else
	PACKAGE_LINT=false
fi

curdir=${PWD##*/}
curpath=${PWD}
cd .upgrade/webpack-bsd-master
npm install

./utils/expect-script.sh "$PACKAGE_NAME" "$PACKAGE_DESCRIPTION" "$PACKAGE_AUTHOR"

echo $PACKAGE_NAME

cd $PACKAGE_NAME
npm install

cd $curpath


################
# Clean up
################
# rm -rf .upgrade/
rm -rf .backup/

echo

exit 0