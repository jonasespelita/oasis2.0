class CreateTfassessments < ActiveRecord::Migration
  def self.up
    create_table :tfassessments do |t|
      t.integer :idNo
      t.string :gradingTerm
      t.float :payAmt
      t.date :balanceAsOf

      t.timestamps
    end
  end

  def self.down
    drop_table :tfassessments
  end
end
