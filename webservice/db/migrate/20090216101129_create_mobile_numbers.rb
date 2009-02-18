class CreateMobileNumbers < ActiveRecord::Migration
  def self.up
    create_table :mobile_numbers do |t|
      t.integer :idNo
      t.string :mobileNumber
      t.date :enrol_date
      #t.timestamps
    end
  end

  def self.down
    drop_table :mobile_numbers
  end
end
