require File.dirname(__FILE__) + '/../test_helper'

class GistsControllerTest < ActionController::TestCase
  
  # Generated tests
  
  test "should_get_index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end
  
  test "should only have articles" do
    get :index
    assert assigns(:posts).size > 0
    assigns(:posts).each do |post|
      assert_equal Gist, post.class
    end
  end
end