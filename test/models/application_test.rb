require "test_helper"

class ApplicationTest < ActiveSupport::TestCase
  setup do
    @application_one = applications(:one)
  end

  test "when application has no events, status should be applied" do
    assert_equal "applied", @application_one.status, "status should be applied"
  end

  test "creating a new event should update application's last_event_type column" do
    assert_nil @application_one.last_event_type, "last_event_type shoud be nil"
    @application_one.events.create!(type: "Application::Event::Interview")
    assert_equal "Application::Event::Interview", @application_one.last_event_type, "status should be Application::Event::Interview"
  end

  test "when application's last event is Application::Event::Interview, status should be interview" do
    @application_one.events.create!(type: "Application::Event::Interview")
    assert_equal "interview", @application_one.status, "status should be interview"
  end

  test "when application's last event is Application::Event::Hired, status should be hired" do
    @application_one.events.create!(type: "Application::Event::Hired")
    assert_equal "hired", @application_one.status, "status should be hired"
  end

  test "when application's last event is Application::Event::Rejected, status should be rejected" do
    @application_one.events.create!(type: "Application::Event::Rejected")
    assert_equal "rejected", @application_one.status, "status should be rejected"
  end

  test "when application's last event is Application::Event::Note, status should not change" do
    @application_one.events.create!(type: "Application::Event::Interview")
    assert_equal "interview", @application_one.status, "status should be interview"
    @application_one.events.create!(type: "Application::Event::Note")
    assert_equal "interview", @application_one.status, "status should still be interview"
  end
end
