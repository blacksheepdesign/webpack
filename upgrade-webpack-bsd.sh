#!/bin/bash

################################
# SETUP
################################

	# Start with new line
	echo

	# Define some colours
	GREEN='\033[1;32m'
	NC='\033[0m' # No Color

	# Get project details
	PACKAGE_NAME=$(cat package.json \
	  | grep name \
	  | head -1 \
	  | awk -F: '{ print $2 }' \
	  | sed 's/[",]//g' \
	  | xargs )
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


################################
# TIDY UP
################################

	rm -rf .upgrade/
	rm -rf .backup/


################################
# CONFIRM DIR IS A PROJECT
################################

	printf "# ${GREEN}Checking project ...${NC}\n"

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


################################
# BACKUP
################################

	printf "# ${GREEN}Creating backup of project ...${NC}\n"
	UNIQDATE=`date +%s`

	mkdir -p "/tmp/.webpack-bsd-backup-$UNIQDATE/"
	rsync -r --filter=':- .gitignore' "./" "/tmp/.webpack-bsd-backup-$UNIQDATE/"
	mv "/tmp/.webpack-bsd-backup-$UNIQDATE" ".backup"
	echo


################################
# DOWNLOAD TEMPLATE
################################

	printf "# ${GREEN}Downloading latest version of webpack-bsd ...${NC}\n"
	mkdir -p .upgrade/
	cd .upgrade
	curl -sL https://github.com/blacksheepdesign/webpack-bsd/archive/master.tar.gz | tar xz
	cd ..
	echo


################################
# INITIALISE AN UPDATED VUE PROJECT
################################

	printf "# ${GREEN}Running install script ...${NC}\n"
	printf "# ========================"
	echo

	curpath=${PWD}
	cd .upgrade/webpack-bsd-master
	npm install

	./utils/expect-script.sh "$PACKAGE_NAME" "$PACKAGE_DESCRIPTION" "$PACKAGE_AUTHOR"

	cd $curpath


################################
# REPLACE OUTDATED FILES
# Add replace functions here before committing a new version of the webpack starter.
################################

	until [ -z "$1" ]; do
		case "$1" in
			--skip-build-dir) shift; SKIPBUILDDIR=true; shift ;;
			--skip-config-dir) shift; SKIPCONFIGDIR=true; shift ;;
			--skip-config-env) shift; SKIPCONFIGENV=true; shift ;;
			--skip-settings) shift; SKIPSETTINGS=true; shift ;;
			--skip-vagrant) shift; SKIPVAGRANT=true; shift ;;
			--skip-npm) shift; SKIPNPM=true; shift ;;
		esac
	done

	# Upgrade build/ directory
	rm -rf config/
	if [ -z "$SKIPBUILDDIR" ]; then
		rm -rf build
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/build ./
	else
		printf "# ${GREEN}Skipping upgrading build/ directory ...${NC}\n"
	fi

	# Upgrade config/ directory
	if [[ -z "$SKIPCONFIGDIR" || -z "$SKIPCONFIGENV" ]]; then
		rm -rf config
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/config ./
	else
		printf "# ${GREEN}Skipping upgrading config/ directory ...${NC}\n"
	fi

	# Upgrade index.js config
	if [ -z "$SKIPCONFIGENV" ]; then
		SKIPPEDCONFENV=true
	else
		printf "# ${GREEN}Upgrading config/index.js ...${NC}\n"
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/config/index.js ./config/index.js
	fi

	# Upgrade settings files
	if [ -z "$SKIPSETTINGS" ]; then
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/.babelrc .babelrc
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/.editorconfig .editorconfig
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/.eslintrc.js .eslintrc.js
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/.postcssrc.js .postcssrc.js
	else
		printf "# ${GREEN}Skipping upgrading settings files ...${NC}\n"
	fi

	# Upgrade Vagrant files
	if [ -z "$SKIPVAGRANT" ]; then
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/bootstrap.sh bootstrap.sh
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/hosts-down.sh hosts-down.sh
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/hosts-up.sh hosts-up.sh
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/Vagrantfile Vagrantfile
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/wordpress.sh wordpress.sh
	else
		printf "# ${GREEN}Skipping upgrading Vagrant-related files ...${NC}\n"
	fi

	# Upgrade NPM modules
	if [ -z "$SKIPNPM" ]; then
		printf "# ${GREEN}Upgrading NPM modules ...${NC}\n"
		printf "# ========================"
		echo
		rm -rf node_modules
		npm install
	else
		printf "# ${GREEN}Skipping update of NPM modules ...${NC}\n"
	fi

	if [[ ! -f style.css ]]; then
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/style.css style.css
	fi

	if [[ ! -f functions.php ]]; then
		mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/functions.php functions.php
	fi

	mv .upgrade/webpack-bsd-master/$PACKAGE_NAME/index.html index.html
	echo


################################
# CLEAN UP
################################

	rm -rf .upgrade/
	rm -rf .backup/

	printf "# ${GREEN}Project update complete!${NC}\n"
	printf "# ========================"

	# End with newline
	echo

	exit 0
