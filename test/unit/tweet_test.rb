require File.dirname(__FILE__) + '/../test_helper'

class TweetTest < ActiveSupport::TestCase
  
  def test_should_create_tweet
    assert_difference 'Tweet.count' do
      tweet = create_tweet
    end
  end
  
  def test_should_know_if_reply_with_colon
    tweet = create_tweet :content => "@somebody: Well I wouldn't say that"
    assert tweet.reply?, "didn't recognize reply with colon"
  end
  
  def test_should_know_if_reply_sans_colon
    tweet = create_tweet :content => "@somebody Well I wouldn't say that"
    assert tweet.reply?, "didn't recognize reply sans colon"
  end
  
  def test_should_not_give_false_positives_for_reply_helper
     tweet = create_tweet :content => "just referencing @somebody"
      assert ! tweet.reply?, "false positive on non-reply"
  end

  def test_should_generate_header
    tweet = new_tweet(:header => nil, :content => 'I was just thinking about this one thing')
    assert_nil tweet.header
    assert tweet.save
    assert_not_nil tweet.header
    assert tweet.header.starts_with?("Tweet: ")
  end
  
protected

  def create_tweet(options={})
    t = new_tweet(options)
    t.save
    t
  end

  def new_tweet(options={})
    Tweet.new({:header => 'some header', :content => 'Some content', :user_id => users(:quentin).id, :feed_id => feeds(:one).id, :permalink => 'ok' }.merge(options))
  end
end
