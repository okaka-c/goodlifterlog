require "test_helper"

class Record::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_comments_new_url
    assert_response :success
  end

  test "should get create" do
    get record_comments_create_url
    assert_response :success
  end
end
