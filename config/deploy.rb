lock '3.14.0'

set :application, 'cocktail-hub'
set :deploy_to, '/var/www/cocktail-hub'

set :repo_url, 'git@github.com:takuya-33/cocktail-hub.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :linked_files, fetch(:linked_files, []).push('config/master.key')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.1'

set :ssh_options, auth_methods: ['publickey'], keys: ['~/.ssh/cocktail-hub-ssh-key.pem']

set :unicorn_pid, -> { "/var/www/cocktail-hub/current/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "/var/www/cocktail-hub/current/config/unicorn/production.rb" }

set :keep_releases, 5

set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end