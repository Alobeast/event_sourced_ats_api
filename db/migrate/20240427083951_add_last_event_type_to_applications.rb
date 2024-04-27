class AddLastEventTypeToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :last_event_type, :string
  end
end
