class Job::Event < ApplicationRecord
  belongs_to :job

  after_create :update_job_last_event_type

  private

  def update_job_last_event_type
    job.update_last_event_type
  end
end
