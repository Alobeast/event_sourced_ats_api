require "test_helper"

class JobTest < ActiveSupport::TestCase
  setup do
    @job_one = jobs(:one)
  end

  test "when job has no events, status should be deactivated" do
    assert_equal "deactivated", @job_one.status, "status should be deactivated"
  end

  test "creating a new event should update job's last_event_type column" do
    assert_nil @job_one.last_event_type, "last_event_type shoud be nil"
    @job_one.events.create!(type: "Job::Event::Activated")
    assert_equal "Job::Event::Activated", @job_one.last_event_type, "status should be Job::Event::Activated"
  end

  test "when job's last event is Job::Event::Activated, status should be activated" do
    @job_one.events.create!(type: "Job::Event::Deactivated")
    @job_one.events.create!(type: "Job::Event::Activated")
    assert_equal "activated", @job_one.status, "status should be activated"
  end

  test "when job's last event is Job::Event::Deactivated, status should be deactivated" do
    @job_one.events.create!(type: "Job::Event::Activated")
    @job_one.events.create!(type: "Job::Event::Deactivated")
    assert_equal "deactivated", @job_one.status, "status should be deactivated"
  end

  test "when job has a new hire, hire count should be incremented" do
    assert_equal 0, @job_one.hired_count, "there should be no hire"
    application = @job_one.applications.first
    assert_difference "@job_one.hired_count", 1, "hire count should be incremented" do
      application.events.create!(
        type: "Application::Event::Hired",
        hire_date: Date.today
      )
    end
  end

  test "when job has a new rejection, rejection count should be incremented" do
    assert_equal 0, @job_one.rejected_count, "there should be no rejection"
    application = @job_one.applications.first
    assert_difference "@job_one.rejected_count", 1, "rejection count should be incremented" do
      application.events.create!(
        type: "Application::Event::Rejected",
        hire_date: Date.today
      )
    end
  end

  test "ongoing count should be updated for every new hire or rejection" do
    application_one = @job_one.applications.create!(candidate_name: "Applicant one")
    application_two = @job_one.applications.create!(candidate_name: "Applicant two")
    application_three = @job_one.applications.create!(candidate_name: "Applicant three")
    assert_equal 3, @job_one.ongoing_application_count, "there should be 3 ongoing applications"

    assert_difference "@job_one.ongoing_application_count", -1, "ongoing count should be decremented" do
      application_two.events.create!(
        type: "Application::Event::Rejected",
        hire_date: Date.today
      )
    end
    assert_difference "@job_one.ongoing_application_count", -1, "ongoing count should be decremented" do
      application_three.events.create!(
        type: "Application::Event::Hired",
        hire_date: Date.today
      )
    end
  end
end
