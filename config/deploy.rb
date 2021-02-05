lock '3.15.0'

set :application, 'STUDIO-DIG'

set :repo_url,  'git@github.com:osugisan/STUDIO-DIG.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/studio-dig.pem'] 

set :puma_pid, -> { "#{shared_path}/tmp/pids/puma.pid" }

set :puma_config_path, -> { "#{current_path}/config/puma.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end
