# Introduction

This is the vue/webpack starter project used by Blacksheepdesign. It's based on and tracks [vuejs-templates/webpack](https://github.com/vuejs-templates/webpack) and has many similarities. The reasons we created this starter project was because we needed a specific solution to meet a few additional requirements:
+ Ability to build directly into a WordPress theme
+ Include a series of components frequently used on our websites
+ Automatically configure and provision a Vagrant VM with WordPress installed
+ Manage databases, and track the WP MySQL database in the project's git repository

As such, the scope of this template doesn't just cover front end SPA development, but also includes the WordPress as a BaaS provider.

In addition to the wider scope, this project does not include and e2e or unit testing features like the official Webpack starter.

This boilerplate is targeted towards large, serious projects and assumes you are somewhat familiar with Webpack and `vue-loader`. Make sure to also read [`vue-loader`'s documentation](https://vue-loader.vuejs.org/) for common workflow recipes.

## Quickstart

To use this template, scaffold a project with [vue-cli](https://github.com/vuejs/vue-cli). **It is recommended to use npm 3+ for a more efficient dependency tree.**

``` bash
$ npm install -g vue-cli
$ vue init blacksheepdesign/webpack-bsd my-project
```
