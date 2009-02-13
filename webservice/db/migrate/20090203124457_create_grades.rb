class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades do |t|
      t.integer :idNo
      t.integer :semester
      t.integer :endSchYr
      t.string :courseNo
      t.string :descriptiveTitle
      t.integer :units
      t.integer :grade
      t.string :remark

      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
