require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get wordpress" do
    get :wordpress
    assert_response :success
  end

  test "should get github" do
    get :github
    assert_response :success
  end

  test "should get freesoftware" do
    get :freesoftware
    assert_response :success
  end

end
