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
    # number of jobs from seed 11
    assert_equal 11, json_response.size
  end

  test "a job line should have all expected information present" do
    get jobs_url, as: :json
    json_response = JSON.parse(response.body)

    informations = json_response.first.keys
    assert informations.include?("title"), "job title should be present"
    assert informations.include?("hired_count"), "hired count should be present"
    assert informations.include?("rejected_count"), "rejected count should be present"
    assert informations.include?("status"), "status should be present"
    assert informations.include?("ongoing_application_count"), "ongoing applications count should be present"
  end

  test "the proper values should be present" do
    get jobs_url, as: :json
    json_response = JSON.parse(response.body)

    job = json_response.find { |job| job["title"] == "Job controller tester" }

    assert_not_nil job, "created job should be present"
    assert_equal "activated", job["status"], "status should be activated"
    assert_equal 1, job["hired_count"], "hired count should be 1"
    assert_equal 1, job["rejected_count"], "rejected count should be 1"
    assert_equal 1, job["ongoing_application_count"], "ongoing applications count should be 1"
  end
end
