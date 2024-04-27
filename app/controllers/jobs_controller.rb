class JobsController < ApplicationController
  def index
    jobs = Job.all

    render json: jobs.as_json
  end
end
