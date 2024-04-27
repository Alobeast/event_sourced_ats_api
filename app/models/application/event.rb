class Application::Event < ApplicationRecord
  belongs_to :application

  after_create :update_application_and_job

  private

  def update_application_and_job
    ApplicationRecord.transaction do
      application.update_last_event_type
      if type == "Application::Event::Interview"
        application.update_first_interview_date(interview_date)
      end
      increment_counts
    end
  end

  def increment_counts
    case type
    when "Application::Event::Note"
      application.increment!(:note_count)
    when "Application::Event::Hired"
      application.job.increment!(:hired_count)
    when "Application::Event::Rejected"
      application.job.increment!(:rejected_count)
    end
  end
end
