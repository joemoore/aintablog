Before do  
  @user = Factory.create(:user)
  @new_article = Factory.create(:article, :user => @user)
  @old_article = Factory.create(:article, :user => @user, :created_at => 1.year.ago)
end

Given /I am on the new post page/ do
  visit "/posts/new"
end

Given /I am on the post page/ do
  visit "/posts"
end

Given /^the following posts:$/ do |posts|
  Post.create!(posts.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) post$/ do |pos|
  visit posts_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following posts:$/ do |posts|
  posts.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end

Then /^I should see new posts without year$/ do 
  puts 'matched new'
  post_id = "post_#{@new_article.id}"
  response.should_not have_selector("#posts > ##{post_id} > .date > span.year")
end


Then /^I should see posts from last year with year$/ do 
  puts 'matched old'
  post_id = "post_#{@old_article.id}"
  response.should have_selector("#posts > ##{post_id} > .date > span.year") do |span|
    span.inner_text.should include(@old_post.created_at.year.last(2))
  end
end
# 
# 
# Feature: View posts
#   In order to know when posts were posted
#   we want to see posts with dates
#   
#   Scenario: Viewing new posts
#     Given I am on the post page
#     Then I should see new posts without year
#     
# 
#   Scenario: Viewing older posts
#     Given I am on the post page
#     Then I should see posts from last year with year
