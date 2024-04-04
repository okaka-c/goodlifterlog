require "test_helper"

class CompetitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get competitions_index_url
    assert_response :success
  end
end
