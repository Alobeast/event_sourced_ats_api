class Application::Event < ApplicationRecord
  belongs_to :application

  after_create :update_application_last_event_type

  def update_application_last_event_type
    application.update_last_event_type
  end
end
