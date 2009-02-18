class CreateCourseOfferings < ActiveRecord::Migration
  def self.up
    create_table :course_offerings do |t|
      t.integer :semester
      t.integer :endSchYr
      t.string :college
      t.integer :code
      t.string :courseNo
      t.string :descriptiveTitle
      t.string :time
      t.string :day
      t.string :room

      t.timestamps
    end
  end

  def self.down
    drop_table :course_offerings
  end
end
