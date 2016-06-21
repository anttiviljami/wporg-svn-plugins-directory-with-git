#!/usr/bin/env ruby
##
# update-plugins.rb
#
# Updates plugins from git and pushes them to the WordPress.org svn plugin
# repository
##

BASEDIR = File.expand_path File.dirname __FILE__

require File.join(BASEDIR, '/src/main.rb')
