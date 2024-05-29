require "test_helper"

class Record::BenchPressesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get record_bench_presses_new_url
    assert_response :success
  end

  test "should get create" do
    get record_bench_presses_create_url
    assert_response :success
  end
end
