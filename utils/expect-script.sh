#! /usr/bin/expect -f

# Get project details
set PACKAGE_NAME [lindex $argv 0]
set PACKAGE_DESCRIPTION [lindex $argv 1]
set PACKAGE_AUTHOR [lindex $argv 2]

set timeout 360

spawn ./node_modules/.bin/vue init . [string trim $PACKAGE_NAME]

# This happens because of
# https://github.com/vuejs/vue-cli/issues/291
expect "Project name" { send [string trim $PACKAGE_NAME]\r }
expect "Project description" { send [string trim $PACKAGE_DESCRIPTION]\r }
expect "Author" { send [string trim $PACKAGE_AUTHOR]\r }
expect "Vue build" { send "\r" }
expect "Install vue-router?" { send "\r" }
expect "Use ESLint to lint your code?" { send "\r" }
expect "Pick an ESLint preset" { send "\r" }
expect "Should we run" { send "\r" }