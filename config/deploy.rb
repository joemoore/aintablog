set :use_sudo, false

set :application, "40withegg"

default_run_options[:pty] = true
set :repository,  "."
set :user, "josephm"
set :branch, "master"
set :deploy_via, :copy

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/josephm/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "64.22.96.76"
role :web, "64.22.96.76"
# role :db,  "", :primary => true

namespace :cache do
  desc "Remove cache directory, essentially expiring the whole thing"
  task :expire do
    run "rm -rf #{current_path}/public/cache"
  end
end