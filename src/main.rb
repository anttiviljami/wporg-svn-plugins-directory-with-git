##
# main.rb
#
# The main logic for the update automation
##

require 'yaml'
require 'shellwords'
require 'colorize'

# Load the list of plugins from config.yml
if File.exist? File.join(BASEDIR, 'config.yml')
  plugins = YAML.load_file(File.join(BASEDIR, 'config.yml'))['plugins']
else
  puts "Error:".red + " config.yml seems to be missing."
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
    puts "Pulling git repository for #{name} at #{gitdir}..."
    command = "cd #{gitdir.shellescape} && git pull #{gitsrc} #{gitbranch}"
  else
    puts "Cloning git repository for #{name} to #{gitdir}..."
    command = "git clone #{gitsrc} #{gitdir.shellescape}"
    command += " --branch #{gitbranch}" unless gitbranch == ''
  end

  result = system(command)
  unless result
    puts "Warning:".yellow + " Couldn't fetch git repo for #{name}, skipping updates..."
    next
  end

  # Check out the wordpress.org svn repo
  puts "Checking out svn repository for #{name} to #{svndir}..."
  result = system "svn co #{svnsrc} #{svndir.shellescape}"

  unless result
    puts "Warning:".yellow + " Couldn't fetch svn repo for #{name}, skipping updates..."
    next
  end
end

