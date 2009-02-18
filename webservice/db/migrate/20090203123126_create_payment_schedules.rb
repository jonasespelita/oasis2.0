class CreatePaymentSchedules < ActiveRecord::Migration
  def self.up
    create_table :payment_schedules do |t|
      t.integer :idNo
      t.timestamp :dateOfPayment
      t.float :amt
      t.string :textDetail

      #t.timestamps
    end
  end

  def self.down
    drop_table :payment_schedules
  end
end
