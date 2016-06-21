# Up-to-Date WordPress.org Plugins

This repository provides tools to automate pushing updates from git to wordpress.org svn repositories

## Usage

Set up a config.yml file using the following format the root directory. You can use config-sample.yml as an example.

```
plugins:
  wp-pdf-templates:
    git: git@github.com:anttiviljami/wp-pdf-templates.git
    svn: https://plugins.svn.wordpress.org/wp-pdf-templates/
  wp-libre-form:
    git: git@github.com:anttiviljami/wp-libre-form.git
    svn: https://plugins.svn.wordpress.org/wp-libre-form/
```

Then, simply run the update-plugins.rb -script.

```
$ ./update-plugins.rb
```

