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
end
