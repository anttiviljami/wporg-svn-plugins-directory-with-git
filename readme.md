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

```sh
$ ./update-plugins.rb
```

### Example run

Here's an example of how an update procedure might go.

```
$ ./update-plugins.rb
----> Cloning git repository for wp-post-acl to /Users/antti/up-to-date-wp-plugins/git/wp-post-acl...
Cloning into '/Users/antti/up-to-date-wp-plugins/git/wp-post-acl'...
remote: Counting objects: 71, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 71 (delta 0), reused 0 (delta 0), pack-reused 68
Receiving objects: 100% (71/71), 425.35 KiB | 197.00 KiB/s, done.
Resolving deltas: 100% (32/32), done.
Checking connectivity... done.
----> Checking out svn repository for wp-post-acl to /Users/antti/up-to-date-wp-plugins/svn/wp-post-acl...
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
