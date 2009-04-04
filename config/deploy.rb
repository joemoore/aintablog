set :use_sudo, false

set :application, "aintablog"

default_run_options[:pty] = true
set :repository,  "."
set :user, "josephm"
set :branch, "40withegg"
set :deploy_via, :copy

set :keep_releases, 5


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/josephm/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git


task :production do
  
  set :dbuser,        "josephm_blog"
  set :dbpass,        "8106"
  
  set :production_database, "josephm_aintprod"

  # comment out if it gives you trouble. newest net/ssh needs this set.
  ssh_options[:paranoid] = false

  role :app, "40withegg.com"
  role :web, "40withegg.com"
  role :db,  "40withegg.com", :primary => true

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
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  task :symlink_assets do 
    run "ln -s #{shared_path}/public/assets #{current_path}/public/assets"
  end
end

after 'deploy', 'deploy:cleanup'
after "deploy:migrations", "deploy:cleanup"
after 'deploy:symlink', 'deploy:symlink_assets'
