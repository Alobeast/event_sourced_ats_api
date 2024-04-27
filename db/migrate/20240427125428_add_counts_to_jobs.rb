class AddCountsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :hired_count, :integer, default: 0
    add_column :jobs, :rejected_count, :integer, default: 0
  end
end
