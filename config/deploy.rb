set :use_sudo, false

set :application, "40withegg"

default_run_options[:pty] = true
set :repository,  "."
set :user, "josephm"
set :branch, "master"
set :deploy_via, :copy

set :keep_releases,       5


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/josephm/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git


task :production do
  
  set :dbuser,        "josephm_root"
  set :dbpass,        "password"
  
  set :production_database, "josephm_40prod"
  set :production_dbhost,   "localhost"

  # comment out if it gives you trouble. newest net/ssh needs this set.
  ssh_options[:paranoid] = false

  role :app, "64.22.96.76"
  role :web, "64.22.96.76"
  role :db,  "64.22.96.76", :primary => true

  set :rails_env, "production"
  set :environment_database, defer { production_database }
  set :environment_dbhost, defer { production_dbhost }
end


namespace :cache do
  desc "Remove cache directory, essentially expiring the whole thing"
  task :expire do
    run "rm -rf #{current_path}/public/cache"
  end
end

namespace :deploy do 
  
  task :restart do
    run "kill -9 `ps -ef |grep josephm |grep fcgi |grep -v grep |awk '{print $2}'`"
  end
end

after 'deploy', 'deploy:cleanup'
after "deploy:migrations", "deploy:cleanup"

