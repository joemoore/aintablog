class Twitter < Feed
  
  entries_become :tweets do |tweet, entry|
    content = entry.content.gsub(/\A\w*:?\s/, '')
    tweet.content = content
    words = content.split(' ')
    header = words[0..4].join(' ')
    tweet.header = 'Tweet: ' + header
    tweet.header << ' ...' unless header.ends_with?('.')
    tweet.permalink = entry.urls.first
    tweet.created_at = entry.try(:date_published)
    tweet.save ? tweet : tweet.destroy
  end

end