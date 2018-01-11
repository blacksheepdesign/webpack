#! /usr/bin/expect -f
set timeout 360

spawn ./node_modules/.bin/vue init . $curdir

# This happens because of
# https://github.com/vuejs/vue-cli/issues/291
expect "Project name" { send $PACKAGE_NAME }
expect "Project description" { send $PACKAGE_DESCRIPTION }
expect "Author" { send $PACKAGE_AUTHOR }
expect "Vue build" { send "\n" }
expect "Install vue-router?" { send "\n" }
expect "Pick an ESLint preset" { send "\n" }
expect "Should we run" { send "\n" }