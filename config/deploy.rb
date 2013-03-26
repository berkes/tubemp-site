require 'bundler/capistrano'

set :application, "ET_tubemp"
set :repository,  "git@github.com:berkes/tubemp.git"
set :deploy_to, "/var/www/#{application}"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "li308-140.members.linode.com" # Your HTTP server, Apache/etc
role :app, "li308-140.members.linode.com" # This may be the same as your `Web` server
# Gnome-terminal or Ubuntu or whatever trows errors. No idea what 
# this does, but it fixes the issue. :D
default_run_options[:pty] = true

# Agent forwarding: use my local priv ssh keys for access to github.
ssh_options[:forward_agent] = true

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


