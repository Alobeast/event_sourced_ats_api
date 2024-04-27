class Job < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :events, class_name: "Job::Event", dependent: :destroy

  def update_last_event_type
    update(last_event_type: events.order(created_at: :asc).last&.type)
  end

  def status
    last_event_type&.gsub("Job::Event::", "")&.downcase || "deactivated"
  end
end
