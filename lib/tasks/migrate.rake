namespace :migrate do
  desc "Move Link#cite to Link#content"
  task :links => :environment do
    Link.find(:all).each do |link|
      link.content ||= link.cite
      puts "updating link: #{link.permalink}" if link.save
      puts link.reload.content
    end
  end
end

namespace :db do
  namespace :migrate do
    desc "migrate posts and comments from mephisto to aintablog.  See lib/migrate_from_mephisto.rb for details."
    task :from_mephisto => :environment do
      require 'migrate_from_mephisto'
      MigrateFromMephisto.run
    end
  end
end