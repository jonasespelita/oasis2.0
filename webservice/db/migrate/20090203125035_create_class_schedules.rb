class CreateClassSchedules < ActiveRecord::Migration
  def self.up
    create_table :class_schedules do |t|
      t.integer :idNo
      t.integer :code
      t.string :courseNo
      t.string :descriptiveTitle
      t.integer :units
      t.time :time
      t.string :day
      t.string :room

      t.timestamps
    end
  end

  def self.down
    drop_table :class_schedules
  end
end
