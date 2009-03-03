Feature: View posts
  In order to know when posts were posted
  we want to see posts with dates
  
  Scenario: Viewing new posts
    Given I am on the post page
    Then I should see new posts without year
    

  Scenario: Viewing older posts
    Given I am on the post page
    Then I should see posts from last year with year

  # 
  # Scenario: Delete post
  #   Given the following posts:
  #     ||
  #     ||
  #     ||
  #     ||
  #     ||
  #   When I delete the 3rd post
  #   Then I should see the following posts:
  #     ||
  #     ||
  #     ||
  #     ||
