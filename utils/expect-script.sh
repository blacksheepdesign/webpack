#! /usr/bin/expect -f

# Get project details
set PACKAGE_NAME [lindex $argv 0]
set PACKAGE_DESCRIPTION [lindex $argv 1]
set PACKAGE_AUTHOR [lindex $argv 2]

set timeout 360

spawn ./node_modules/.bin/vue init . [string trim $PACKAGE_NAME]

# This happens because of
# https://github.com/vuejs/vue-cli/issues/291
expect "Project name" { send [string trim $PACKAGE_NAME]\n }
expect "Project description" { send [string trim $PACKAGE_DESCRIPTION]\n }
expect "Author" { send [string trim $PACKAGE_AUTHOR]\n }
expect "Vue build" { send "\n" }
expect "Install vue-router?" { send "\n" }
expect "Use ESLint to lint your code?" { send "\n" }
expect "Pick an ESLint preset" { send "\n" }
expect "Should we run"
send "\[B\[B\r"
expect eof