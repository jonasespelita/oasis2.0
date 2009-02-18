class CreateTempEmails < ActiveRecord::Migration
  def self.up
    create_table :temp_emails do |t|
		t.text :email
      t.timestamps
    end
  end

  def self.down
    drop_table :temp_emails
  end
end
