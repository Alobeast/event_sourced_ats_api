class AddFirstInterviewDateToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :first_interview_date, :datetime
  end
end
