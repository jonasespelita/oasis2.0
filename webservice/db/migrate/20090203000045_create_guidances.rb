class CreateGuidances < ActiveRecord::Migration
  def self.up
    create_table :guidances do |t|
      t.integer :idNo
      t.string :time
      t.string :day
      t.string :room
      t.string :guidanceStatus

      #t.timestamps
    end
  end

  def self.down
    drop_table :guidances
  end
end
