# To use this migrator, you must import the contents of mephisto's 'contents'
# table into your aintablog database.  For example:
#   1. using mysqldump from mysql: `mysqldump -uUSER -pPASS mephisto_dev contents > contents.sql`
#   2. using mysql command to import: `mysql -uUSER -pPASS aintablog_dev < contents.sql`
#   3. run `rake db:migrate:from_mephisto RAILS_ENV=development`

class MigrateFromMephisto
  def self.run
    user = User.first
    Mephisto::Content.find_all_by_type('Article').each do |content|
      created_at = content.created_at
      prefix = "#{created_at.year}/#{created_at.month}/#{created_at.day}"
      article = user.articles.create(:header => content.title,
                                     :permalink => "#{content.permalink}",
                                     :content => content.body)
      article.created_at = content.created_at
      article.save_without_validation!

      comments = Mephisto::Content.find_all_by_article_id_and_approved_and_type(content.id, true, 'Comment').each do |comment|
        article.comments.create(:body => comment.body_html,
                                :email => comment.author_email,
                                :website => comment.author_url,
                                :name => comment.author,
                                :spam => 0
        )
      end
    end
  end
end