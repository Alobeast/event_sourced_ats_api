require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Job.destroy_all
    load Rails.root.join("db/seeds.rb")
  end

  test "should get index, response should be json" do
    get applications_url, as: :json
    assert_response :success, "should access applications index"
    assert_includes response.content_type, 'application/json', "result type should be json"
  end

  test "should return all applications linked to activated jobs" do
    get applications_url, as: :json
    json_response = JSON.parse(response.body)
    # from seed 5 applications/job for 5 activated jobs
    assert_equal 25, json_response.size
  end
end
