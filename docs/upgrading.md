# Upgrading template

It's possible to update your project to the latest version of this template. The update script will keep back commonly edited areas of the template, and apply updates to everything else.

## Simple upgrade
To run the update script, enter this command at the root level of your project.

``` sh
curl -s https://raw.githubusercontent.com/blacksheepdesign/webpack-bsd/master/upgrade-webpack-bsd.sh | bash -s
```

## Options
If you would like to force the update script to skip certain files, you have the option to do so by supplying one of the following arguments at the end of the command.

E.g.
``` sh
curl -s https://raw.githubusercontent.com/blacksheepdesign/webpack-bsd/master/upgrade-webpack-bsd.sh | bash -s --skip-build-dir
```

Option | Description
------ | -----------
`--skip-build-dir` | Ignores the entire `build/` directory. Useful if you have made adjustments to the build scripts, although typically this is not recommended. Instead create a feature request on the template itself.
`--skip-config-dir` | Ignores the entire `config/` directory. Include this if you have made updates to the config/index.js file.
`--skip-config-env` | Leaves `config/dev.env.js` and `config/prod.env.js` as-is, but upgrades `index.js`, unless `--skip-config-dir` is set.
`--skip-settings` | Ignores all root-level settings files (e.g. `.babelrc`, `.editorconfig`, `.eslintrc.js`, `postcssrc.js`). Include this if you've changed the default configurations.
`--skip-vagrant` | Ignores all Vagrant-related files. For instance, you have added a custom trigger to Vagrant that shouldn't be overwritten.
`--skip-npm` | Prevents the script from updating NPM modules.


## Comparing changes

It is sometimes useful to see the differences between your local project and the template. It's useful in cases where you would want to check certain parts of your project for changes, to see if it's safe to run the upgrade script. To do so, you can run the following commands:

``` sh
git remote add -f template https://github.com/blacksheepdesign/webpack-bsd.git
git remote update
git diff master remotes/template/master
git remote rm template
```

See the [git diff documentation](https://git-scm.com/docs/git-diff) to see how to use the diff command.


## Editing the upgrade script

Each time a new version of the template is pushed, it's important to ensure the upgrade script makes the appropriate updates to apply changes. There are no rules around how updates are applied, but it might be useful to include a function to check if there are any unexpected changes to files before running the replace.

Near the bottom of the file `upgrade-webpack-bsd.sh` there is a section titled *REPLACE OUTDATED FILES*. Add any file operations that are required here. The script creates a temporary directory structure `.upgrade/webpack-bsd-master/$PACKAGE_NAME/build`. In this directory is a built version of the `template/` directory, as if the install script had been run for the first time. You should use this directory to copy any updated files.
