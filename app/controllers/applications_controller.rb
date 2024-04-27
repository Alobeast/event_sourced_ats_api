class ApplicationsController < ApplicationController

  def index
    applications = Application.includes(:job)
                              .where(jobs: {
                                last_event_type: 'Job::Event::Activated'
                              })

    render json: applications.as_json
  end

end
