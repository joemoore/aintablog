class Tweet < Post
  
  validates_presence_of :content
  validate :check_if_reply

  before_create :generate_header
  
  def check_if_reply
    return true if SITE_SETTINGS['import_twitter_replies']
    self.errors.add_to_base("This was a direct reply.") if reply?
  end
  
  def reply?
    content.match(/\A@\w+:?/)
  end

end