class AddTFassessmentTfBreakdownToCurrentStateOfFollower < ActiveRecord::Migration
  def self.up
    add_column :current_state_of_followers, :tf_assessment_rows, :integer
    add_column :current_state_of_followers, :tf_breakdown_rows, :integer
  end

  def self.down
    remove_column :current_state_of_followers, :tf_breakdown_rows
    remove_column :current_state_of_followers, :tf_assessment_rows
  end
end
