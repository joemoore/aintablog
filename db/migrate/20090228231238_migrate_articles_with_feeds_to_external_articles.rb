class MigrateArticlesWithFeedsToExternalArticles < ActiveRecord::Migration
  def self.up
    update "UPDATE posts SET type = 'ExternalArticle' WHERE type = 'Article' AND feed_id IS NOT NULL"
  end

  def self.down
    update "UPDATE posts SET type = 'Article' WHERE type = 'ExternalArticle'"
  end
end
