#! /usr/bin/expect -f

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

echo $PACKAGE_NAME
echo $PACKAGE_DESCRIPTION
echo $PACKAGE_LINT
echo $PACKAGE_AUTHOR

set timeout 360

spawn ./node_modules/.bin/vue init . $PACKAGE_NAME

# This happens because of
# https://github.com/vuejs/vue-cli/issues/291
expect "Project name" { send $PACKAGE_NAME }
expect "Project description" { send $PACKAGE_DESCRIPTION }
expect "Author" { send $PACKAGE_AUTHOR }
expect "Vue build" { send "\n" }
expect "Install vue-router?" { send "\n" }
expect "Pick an ESLint preset" { send "\n" }
expect "Should we run" { send "\n" }