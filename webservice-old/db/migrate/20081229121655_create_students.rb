class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string :idno
      t.string :name
      t.string :data

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
