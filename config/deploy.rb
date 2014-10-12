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
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/thumbs}

# Default value for default_env is {}
set :default_env, { path: "/opt/rbenv/shims:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
