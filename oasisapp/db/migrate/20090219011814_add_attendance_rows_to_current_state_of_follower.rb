class AddAttendanceRowsToCurrentStateOfFollower < ActiveRecord::Migration
  def self.up
    add_column :current_state_of_followers, :attendance_rows, :integer
  end

  def self.down
    remove_column :current_state_of_followers, :attendance_rows
  end
end
