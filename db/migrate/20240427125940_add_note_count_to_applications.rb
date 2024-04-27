class AddNoteCountToApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :applications, :note_count, :integer, default: 0
  end
end
