# Blacksheepdesign Vue.js Starter Template

> We don't recommend this be used by the public as it's specifically designed around our own development workflow. However feel free to use it as a starting template for your own Vue.js projects if you find the packaged components useful. We sugest using [vuejs-templates/webpack](http://vuejs-templates.github.io/webpack) as a more generic starter template.

> Based on [vuejs-templates/webpack](http://vuejs-templates.github.io/webpack), this is a full-featured Webpack setup with hot-reload, lint-on-save & css extraction. It includes packages geared toward creating website applications, so has some useful transition handling, SEO and other tools.

## Documentation

The documentation is still in progress, but you may find these links useful.

- [For webpack-bsd](https://blacksheepdesign.github.io/webpack-bsd/): common questions specific to this template are answered and each part is described in greater detail
- [For Vue 2.0](http://vuejs.org/guide/): general information about how to work with Vue, not specific to this template

## Usage

This is a project template for [vue-cli](https://github.com/vuejs/vue-cli). **It is recommended to use npm 3+ for a more efficient dependency tree.**

``` bash
$ npm install -g vue-cli
$ vue init blacksheepdesign/webpack-bsd my-project
$ cd my-project
$ npm run dev
```

This will scaffold the project using the `master` branch.

The development server will run on port 8080 by default. If that port is already in use on your machine, the next free port will be used.

## What's Included

- `npm run dev`: run a local development environment.
  - Webpack + `vue-loader` for single file Vue components.
  - State preserving hot-reload
  - State preserving compilation error overlay
  - Lint-on-save with ESLint
  - Source maps

- `npm run init`: Provision Vagrant
  - wp-cli installed
  - LAMP stack installed and configured
  - Latest version of Wordpress is installed

- `npm run build`: Production ready build.
  - JavaScript minified with [UglifyJS v3](https://github.com/mishoo/UglifyJS2/tree/harmony).
  - HTML minified with [html-minifier](https://github.com/kangax/html-minifier).
  - CSS across all components extracted into a single file and minified with [cssnano](https://github.com/ben-eb/cssnano).
  - Static assets compiled with version hashes for efficient long-term caching, and an auto-generated production `index.html` with proper URLs to these generated assets.
  - Use `npm run build --report`to build with bundle size analytics.

- `npm run publish`: Push your current build to a live server
  - Exports the database from the Vagrant machine
  - Pushes the theme directory and optionally the database to a remote server

### Fork It And Make Your Own

As with the official webpack template, you can fork this repo to create your own boilerplate, and use it with `vue-cli`:

``` bash
vue init username/repo my-project
```
