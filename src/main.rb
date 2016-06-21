##
# main.rb
##

require 'yaml'
require 'shellwords'

plugins = YAML.load_file(File.join(BASEDIR, 'config.yml'))['plugins']

plugins.each do |plugin|
  name = plugin[0]
  config = plugin[1]

  gitsrc = config['git']
  svnsrc = config['svn']

  gitdir = File.join(BASEDIR, 'git', name)
  svndir = File.join(BASEDIR, 'svn', name)

  if Dir.exist? gitdir
    puts "Pulling git repository for #{name} at #{gitdir}..."
    system "cd #{gitdir.shellescape} && git pull origin"
  else
    puts "Cloning git repository for #{name} to #{gitdir}..."
    system "git clone #{gitsrc} #{gitdir.shellescape}"
  end

  if Dir.exist? svndir
    puts "Updating svn repository for #{name} at #{svndir}..."
    system "svn co #{svnsrc} #{svndir.shellescape}"
  else
    puts "Checking out svn repository for #{name} to #{svndir}..."
    system "svn co #{svnsrc} #{svndir.shellescape}"
  end
end

