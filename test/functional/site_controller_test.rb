require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get ceshi" do
    get :ceshi
    assert_response :success
  end

  test "should get fenxi" do
    get :fenxi
    assert_response :success
  end

end
