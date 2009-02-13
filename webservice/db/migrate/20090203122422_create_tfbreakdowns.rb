class CreateTfbreakdowns < ActiveRecord::Migration
  def self.up
    create_table :tfbreakdowns do |t|
      t.integer :idNo
      t.string :item
      t.float :feeAmt

      t.timestamps
    end
  end

  def self.down
    drop_table :tfbreakdowns
  end
end
