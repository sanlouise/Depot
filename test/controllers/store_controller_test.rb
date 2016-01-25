require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select ".price", /\$[,\d]+\.\d\d/ # $ price like d.dd
  end


end
