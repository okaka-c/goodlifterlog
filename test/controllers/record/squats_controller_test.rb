require "test_helper"

class Record::SquatsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_squats_new_url
    assert_response :success
  end

  test "should get create" do
    get record_squats_create_url
    assert_response :success
  end
end
