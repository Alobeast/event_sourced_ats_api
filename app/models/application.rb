class Application < ApplicationRecord
  belongs_to :job, counter_cache: :applications_count
  has_many :events, class_name: "Application::Event", dependent: :destroy

  def update_last_event_type
    last_significant_event = events.where
                                   .not(type: "Application::Event::Note")
                                   .order(created_at: :asc)
                                   .last

    return if last_significant_event.nil?
    update(last_event_type: last_significant_event.type)
  end

  def update_first_interview_date(interview_date)
    update(first_interview_date: interview_date) if first_interview_date.nil?
  end

  def status
    last_event_type&.gsub("Application::Event::", "")&.downcase || "applied"
  end
end
