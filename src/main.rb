##
# main.rb
#
# The main logic for the update automation
##

require 'yaml'
require 'rake'
require 'shellwords'
require 'colorize'

require File.join(BASEDIR, '/lib/helpers.rb')

# Load the list of plugins from config.yml
if File.exist? File.join(BASEDIR, 'config.yml')
  plugins = YAML.load_file(File.join(BASEDIR, 'config.yml'))['plugins']
else
  notice "Error:".red + " config.yml seems to be missing."
  exit 1
end

# Loop all plugins and update them
plugins.each do |plugin|
  name = plugin[0] # name of the plugin
  config = plugin[1]

  gitsrc = config['git'].split(' ')[0] # remote git url
  gitbranch = config['git'].split(' ')[1] || '' # remote tracking branch (optional)

  svnsrc = config['svn'] # remote svn url

  gitdir = File.join(BASEDIR, 'git', name) # where the git repo will be cloned locally
  svndir = File.join(BASEDIR, 'svn', name) # where the svn repo will be cloned locally

  # Clone or update the git repo
  if Dir.exist? gitdir
    notice "Pulling git repository for #{name} at #{gitdir}..."
    command = "cd #{gitdir.shellescape} && git pull #{gitsrc} #{gitbranch}"
  else
    notice "Cloning git repository for #{name} to #{gitdir}..."
    command = "git clone #{gitsrc} #{gitdir.shellescape}"
    command += " --branch #{gitbranch}" unless gitbranch == ''
  end

  system(command)
  unless $?
    notice "Warning:".yellow + " Couldn't fetch git repo for #{name}, skipping updates..."
    next
  end

  # Check out the wordpress.org svn repo
  notice "Checking out svn repository for #{name} to #{svndir}..."
  system "svn co #{svnsrc} #{svndir.shellescape}"

  unless $?
    notice "Warning:".yellow + " Couldn't fetch svn repo for #{name}, skipping updates..."
    next
  end

  # Copy contents from git repo to svn trunk
  notice "Updating svn trunk from latest git commit for #{name}..."
  FileUtils.cp_r FileList["#{gitdir}/**"].exclude('.git'), File.join(svndir, 'trunk')

  # Get commit message from git
  commitmsg = `cd #{gitdir.shellescape} && git log -1 --pretty=%B`.strip

  # Get latest release from git
  release = `cd #{gitdir.shellescape} && git describe --tags $(git rev-list --tags --max-count=1)`.strip

  # Tag latest release for svn if there is a tag
  if $?
    notice "Tagging latest release #{release} for #{name}..."
    system "cd #{svndir.shellescape} && svn rm --force tags/#{release}"
    system "cd #{svndir.shellescape} && svn cp trunk tags/#{release}"
  end

  # Finally, print svn stat
  system "cd #{svndir.shellescape} && svn stat"

  # Commit svn
  notice "Committing to wordpress.org svn plugin directory with message: \"#{commitmsg}\""
  system "cd #{svndir.shellescape} && svn ci -m \"#{commitmsg}\""

  puts "Success:".green + " #{name} has been updated."
end

