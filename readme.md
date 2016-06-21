# Up-to-Date WordPress.org Plugins
[![License](http://img.shields.io/:license-gpl3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0.html)

This repository provides tools to automate pushing updates from git to wordpress.org svn repositories

## Usage

Set up a config.yml file using the following format the root directory. You can use config-sample.yml as an example.

```yaml
plugins:
  wp-pdf-templates:
    git: git@github.com:anttiviljami/wp-pdf-templates.git master
    svn: https://plugins.svn.wordpress.org/wp-pdf-templates/
  wp-libre-form:
    git: git@github.com:anttiviljami/wp-libre-form.git master
    svn: https://plugins.svn.wordpress.org/wp-libre-form/
```

Then, simply run the update-plugins.rb -script.

```
$ ./update-plugins.rb
```

