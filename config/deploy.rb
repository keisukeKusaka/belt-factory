lock "3.14.1"

set :application, "belt-factory"

set :repo_url, "git@github.com:keisukeKusaka/belt-factory.git"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :rbenv_type, :user
set :rbenv_ruby, "2.6.6"

set :ssh_options, auth_methods: ['publickey']
                  keys: "~/bobokey.pem"

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart' namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
