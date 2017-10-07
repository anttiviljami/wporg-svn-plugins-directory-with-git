# WordPress.org SVN Plugin Directory With Git
![license](https://img.shields.io/badge/license-GPL3-blue.svg) ![VersionEye](https://img.shields.io/versioneye/d/ruby/rails.svg?maxAge=2592000)

This repository provides tools to automate pushing updates from git to wordpress.org svn repositories

## How it works

The `update-plugins.rb` utility will clone both svn and git repos under the svn/ and git/ directories.

Once both repos are present and *up-to-date*, it will copy over any files from the git repo to the svn trunk and tag the newest release.

The script will also attempt to run a `composer install` and run npm scripts with `npm run build` if composer.json and/or package.json files are present, to bundle any files needed to the svn repository.

Finally the script will commit to the wordpress.org svn directory using the latest git commit message.

## Installation

Clone this repository, run bundle install

```
git clone https://github.com/anttiviljami/wporg-svn-plugins-directory-with-git.git
cd wporg-svn-plugins-directory-with-git
bundle install
```

## Requirements

* Ruby >= 1.8
* Git
* Subversion

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

```sh
$ ./update-plugins.rb
```

## Screenshots

Here's an example of how an update procedure might go.

```
$ ./update-plugins.rb
----> Cloning git repository for wp-post-acl to /Users/antti/wporg-svn-plugins-directory-with-git/git/wp-post-acl...
Cloning into '/Users/antti/wporg-svn-plugins-directory-with-git/git/wp-post-acl'...
remote: Counting objects: 71, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 71 (delta 0), reused 0 (delta 0), pack-reused 68
Receiving objects: 100% (71/71), 425.35 KiB | 197.00 KiB/s, done.
Resolving deltas: 100% (32/32), done.
Checking connectivity... done.
----> Checking out svn repository for wp-post-acl to ~/wporg-svn-plugins-directory-with-git/svn/wp-post-acl...
Checked out revision 1449977.
----> Updating svn trunk from latest git commit for wp-post-acl...
----> Tagging latest release 1.0.1 for wp-post-acl...
A       tags/1.0.1
R  +    tags/1.0.1
M  +    tags/1.0.1/readme.txt
M       trunk/readme.txt
----> Committing to wordpress.org svn plugin directory with message: "Tagging version 1.0.1"
Replacing      tags/1.0.1
Sending        tags/1.0.1/readme.txt
Sending        trunk/readme.txt
Transmitting file data ..
Committed revision 1449978.
Success: wp-post-acl has been updated.
```

Example config used:

```yaml
plugins:
  wp-post-acl:
    git: git@github.com:anttiviljami/wp-post-acl.git master
    svn: https://plugins.svn.wordpress.org/wp-post-acl/
```
