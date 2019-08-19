require 'test_helper'

class TimesheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_path
    assert_response :success
  end

end
