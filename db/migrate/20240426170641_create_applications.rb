class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :candidate_name
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
