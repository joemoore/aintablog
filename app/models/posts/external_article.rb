class ExternalArticle < Post
  validates_presence_of :header, :content
  validates_uniqueness_of :permalink, :allow_blank => true

  attr_accessible :content, :header, :permalink, :source

  def link(root='')
    permalink
  end

  def name
    header
  end
end
