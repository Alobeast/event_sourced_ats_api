require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Job.destroy_all
    load Rails.root.join("db/seeds.rb")
  end

  test "should get index, response should be json" do
    get jobs_url, as: :json
    assert_response :success, "should access jobs index"
    assert_includes response.content_type, 'application/json', "result type should be json"
  end

  test "should return all jobs" do
    get jobs_url, as: :json
    json_response = JSON.parse(response.body)
    # number of jobs from seed 10
    assert_equal 10, json_response.size
  end
end
