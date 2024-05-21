require "test_helper"

class Record::WeighInsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_weigh_ins_new_url
    assert_response :success
  end

  test "should get create" do
    get record_weigh_ins_create_url
    assert_response :success
  end
end
