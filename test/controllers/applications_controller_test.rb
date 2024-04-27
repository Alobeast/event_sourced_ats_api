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
    assert_equal 28, json_response.size
  end

  test "result shoud have all data present" do
    get applications_url, as: :json
    json_response = JSON.parse(response.body)

    first_record_line = json_response.first
    infos = first_record_line.keys
    job_infos = first_record_line["job"].keys

    assert infos.include?("candidate_name"), "candidate name title should be present"
    assert infos.include?("first_interview_date"), "first interview date count should be present"
    assert infos.include?("note_count"), "note count should be present"
    assert infos.include?("status"), "status should be present"
    assert infos.include?("job"), "job should be present"
    assert job_infos.include?("title"), "job title should be present"
  end

  test "the proper values should be present" do
    get applications_url, as: :json
    json_response = JSON.parse(response.body)

    application = json_response.find { |app| app["candidate_name"] == "Controller Tester" }

    assert_not_nil application, "created job should be present"
    assert_equal "interview", application["status"], "status should be interview"
    assert_equal 1, application["note_count"], "note count should be 1"
    assert_equal Date.today, Date.parse(application["first_interview_date"]), "first interview date should be today"
    assert_equal "Job controller tester", application["job"]["title"], "job title should be Job controller tester"
  end
end
