class Comment < ActiveRecord::Base
  acts_as_defensio_comment :fields => {
    :content => :body,
    :author => :name,
    :author_email =>:email,
    :author_url => :website,
    :article => :commentable
  } if SITE_SETTINGS[:use_defensio]

  belongs_to :commentable, :polymorphic => true

  validates_presence_of :name, :email, :body
  validate :validate_not_spam
  
  named_scope :spammy, :conditions => 'spam = 1', :order => 'created_at DESC'
  named_scope :hammy, :conditions => 'spam = 0', :order => 'created_at DESC'

  def texilized_body
    text = body || ''
    BlueCloth.new(text).to_html
  end
  
  def validate_not_spam
    errors.add(:spam, "you smell like spam!") if self.spam?
  end
end
