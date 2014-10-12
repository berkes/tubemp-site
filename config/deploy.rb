# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'ET_tubemp'
set :repo_url, 'git@github.com:berkes/tubemp-site.git'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/u/apps/ET_tubemp'

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{.rbenv-vars config/unicorn.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/thumbs}

# Default value for default_env is {}
set :default_env, { path: "/opt/rbenv/shims:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :unicorn_config_path, "#{current_path}/config/unicorn.rb"
set :bundle_bins, fetch(:bundle_bins, []).push("unicorn")

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end

  after 'deploy:publishing', 'restart'
end
