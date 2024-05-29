require "test_helper"

class Record::DeadliftsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_deadlifts_new_url
    assert_response :success
  end

  test "should get create" do
    get record_deadlifts_create_url
    assert_response :success
  end
end
