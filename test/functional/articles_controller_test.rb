require File.dirname(__FILE__) + '/../test_helper'

class ArticlesControllerTest < ActionController::TestCase

  test "should_get_index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end
  
  test "should_get_mta" do
    get :mta
    assert_response :success
    assert_template 'mta'
  end

  test "should only have articles" do
    get :index
    assert assigns(:posts).size > 0
    assigns(:posts).each do |post|
      assert_equal Article, post.class
    end
  end
end