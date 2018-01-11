# Project Structure

``` bash
.
├── build/                      # webpack config files
│   └── ...
├── config/
│   ├── index.js                # main project config
│   └── ...
├── src/
│   ├── main.js                 # app entry file
│   ├── App.vue                 # main app component
│   ├── components/             # ui components
│   │   └── ...
│   └── assets/                 # module assets (processed by webpack)
│       └── ...
├── static/                     # pure static assets (directly copied)
├── .babelrc                    # babel config
├── .editorconfig               # indentation, spaces/tabs and similar settings for your editor
├── .eslintrc.js                # eslint config
├── .eslintignore               # eslint ignore rules
├── .gitignore                  # sensible defaults for gitignore
├── .postcssrc.js               # postcss config
├── bootstrap.sh                # Vagrant bootstrap script
├── hosts-down.sh               # remove site from local hosts file
├── hosts-up.sh                 # add site to local hosts file
├── index.html                  # index.html template
├── package.json                # build scripts and dependencies
├── README.md                   # default README file
├── Vagrantfile                 # Vagrant configuration file
└── wordpress.sh                # Wordpress install script for Vagrant
```

### `build/`

This directory holds the actual configurations for both the development server and the production webpack build. Normally you don't need to touch these files unless you want to customize Webpack loaders, in which case you should probably look at `build/webpack.base.conf.js`.

### `config/index.js`

This is the main configuration file that exposes some of the most common configuration options for the build setup. See [API Proxying During Development](proxy.md) and [Integratiion with Wordpress](backend.md) for more details.

### `src/`

This is where most of your application code will live in. How to structure everything inside this directory is largely up to you; if you are using Vuex, you can consult the [recommendations for Vuex applications](http://vuex.vuejs.org/en/structure.html).

### `static/`

This directory is an escape hatch for static assets that you do not want to process with Webpack. They will be directly copied into the same directory where webpack-built assets are generated.

See [Handling Static Assets](static.md) for more details.

### `index.html`

This is the **template** `index.html` for our single page application. During development and builds, Webpack will generate assets, and the URLs for those generated assets will be automatically injected into this template to render the final HTML.

### `package.json`

The NPM package meta file that contains all the build dependencies and [build commands](commands.md).
