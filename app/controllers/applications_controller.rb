class ApplicationsController < ApplicationController
  def index
    applications = Application.includes(:job)
                              .where(jobs: {
                                last_event_type: 'Job::Event::Activated'
                              })

    render json: applications.as_json(
      only: [:candidate_name, :note_count, :first_interview_date],
      methods: :status,
      include: { job: { only: :title } }
    )
  end
end
