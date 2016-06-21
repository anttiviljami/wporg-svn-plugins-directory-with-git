##
# main.rb
##

require 'yaml'
require 'shellwords'
require 'colorize'

unless File.exist? File.join(BASEDIR, 'config.yml')
  puts "Error:".red + " config.yml seems to be missing."
  exit 1
else
  plugins = YAML.load_file(File.join(BASEDIR, 'config.yml'))['plugins']
end

plugins.each do |plugin|
  name = plugin[0]
  config = plugin[1]

  gitsrc = config['git']
  svnsrc = config['svn']

  gitdir = File.join(BASEDIR, 'git', name)
  svndir = File.join(BASEDIR, 'svn', name)

  if Dir.exist? gitdir
    puts "Pulling git repository for #{name} at #{gitdir}..."
    result = system "cd #{gitdir.shellescape} && git pull #{gitsrc}"
  else
    puts "Cloning git repository for #{name} to #{gitdir}..."
    result = system "git clone #{gitsrc} #{gitdir.shellescape}"
  end

  unless result
    puts "Warning:".yellow + " Couldn't fetch git repo for #{name}, skipping updates..."
    next
  end

  if Dir.exist? svndir
    puts "Updating svn repository for #{name} at #{svndir}..."
    system "svn co #{svnsrc} #{svndir.shellescape}"
  else
    puts "Checking out svn repository for #{name} to #{svndir}..."
    system "svn co #{svnsrc} #{svndir.shellescape}"
  end

  unless result
    puts "Warning:".yellow + " Couldn't fetch svn repo for #{name}, skipping updates..."
    next
  end
end

