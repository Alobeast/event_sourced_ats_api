class AddLastEventTypeToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :last_event_type, :string
  end
end
