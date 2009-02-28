require File.dirname(__FILE__) + '/../test_helper'

class ExternalArticleTest < ActiveSupport::TestCase 
  def test_should_require_header
    article = new_article(:header => nil)
    assert ! article.valid?
    assert_not_nil article.errors.on(:header)
  end
  
  def test_should_require_content
    article = new_article(:content => nil)
    assert ! article.valid?
    assert_not_nil article.errors.on(:content)
  end
  
  def test_should_generate_permalink
    article = new_article(:source => new_user)
    assert article.valid?
    assert_not_nil article.permalink
  end
end
