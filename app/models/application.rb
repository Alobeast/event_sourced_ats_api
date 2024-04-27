class Application < ApplicationRecord
  belongs_to :job
  has_many :events, class_name: "Application::Event", dependent: :destroy

  def update_last_event_type
    last_significant_event = events.where
                                   .not(type: "Application::Event::Note")
                                   .order(created_at: :asc)
                                   .last

    return if last_significant_event.nil?
    update(last_event_type: last_significant_event.type)
  end

  def status
    last_event_type&.gsub("Application::Event::", "")&.downcase || "applied"
  end
end
