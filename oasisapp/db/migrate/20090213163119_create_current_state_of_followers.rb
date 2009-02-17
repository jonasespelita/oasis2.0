class CreateCurrentStateOfFollowers < ActiveRecord::Migration
  def self.up
    create_table :current_state_of_followers do |t|
      t.integer :follower_id
      t.integer :guidance_rows
      t.integer :grade_rows
      t.datetime :attendance_as_of
      t.integer :violation_rows

      t.timestamps
    end
  end

  def self.down
    drop_table :current_state_of_followers
  end
end
