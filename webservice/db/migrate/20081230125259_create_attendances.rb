class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer :idNo
      t.integer :code
      t.string :courseNo
      t.string :absences
      t.string :attendanceStatus
      t.date :asOfDate
      
      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end
