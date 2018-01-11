# Introduction

This is the vue/webpack starter project used by [Blacksheepdesign](https://blacksheepdesign.co.nz). It's based on [vuejs-templates/webpack](https://github.com/vuejs-templates/webpack) and has many similarities, however we created this fork to address a few additional requirements:
+ Ability to build directly into a WordPress theme
+ Include a library of components frequently used on our websites
+ Automatically configure and provision a Vagrant VM with WordPress installed
+ Manage databases, and track the WP MySQL database in the project's git repository

As such, the scope of this template extends to include backend services in addition to simply front-end SPA development.

For the time being, we have removed e2e and unit testing features. We haven't yet adopted a successful unit testing workflow in our site development process.

## Quickstart

To use this template, scaffold a project with [vue-cli](https://github.com/vuejs/vue-cli). **It is recommended to use npm 3+ for a more efficient dependency tree.**

``` bash
$ npm install -g vue-cli # You must install vue-cli in order to use this boilerplate
$ vue init blacksheepdesign/webpack-bsd my-project
```
