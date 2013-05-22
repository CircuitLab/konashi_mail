# require "capistrano/ext/multistage"
require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs"
# set (:bundle_cmd) { "#{release_path}/bin/bundle" }
set (:bundle_cmd) { "/home/ec2-user/.rbenv/versions/2.0.0-p195/bin/bundle" }

load 'deploy/assets'

set :application, "konashi_mail"
set :repository,  "git@github.com:CircuitLab/konashi_mail.git"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

role :web, "ec2-46-51-238-190.ap-northeast-1.compute.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-46-51-238-190.ap-northeast-1.compute.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-46-51-238-190.ap-northeast-1.compute.amazonaws.com", :primary => true # This is where Rails migrations will run
role :db,  "ec2-46-51-238-190.ap-northeast-1.compute.amazonaws.com"

set :deploy_env, 'production'
set :unicorn_env, 'production'
set :rails_env, 'production'
set :environment, "production"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`


set :use_sudo, false
ssh_options[:forward_agent] = true

default_run_options[:pty] = true 
set :user, "ec2-user"
set :group, "ec2-user"
# set :password, ""


set :branch, "master"
set :scm_verbose, true
set :git_shallow_clone, 1 
set :deploy_to, "/home/#{user}/app/#{application}"
set :deploy_via, :remote_cache

set :default_environment, {
  'RBENV_ROOT' => '$HOME/.rbenv',
  'PATH' => "$HOME/.rbenv/shims/:$HOME/.rbenv/bin/:$PATH"
}

shared_path = "#{deploy_to}/shared"
# pids_file = "#{shared_path}/pids/unicorn.pid"
pids_file = "#{current_path}/tmp/pids/server.pid"
namespace :deploy do
  task :start , :roles => :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rbenv exec bundle exec rails s -d"
  end

  task :stop , :roles => :app do
    run "if test -f #{pids_file};then kill `cat #{pids_file}`; fi"
  end

  task :restart, :roles => :app do
    # run "kill -KILL -s USR2 `cat #{pids_file}`"
    stop
    start
  end

end



# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end