class JobsController < ApplicationController
  def index
    jobs = Job.includes(:applications).all

    render json: jobs.as_json(
      only: [:title, :hired_count, :rejected_count],
      methods: [:status, :ongoing_application_count]
    )
  end
end
