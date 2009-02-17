class CreateSitesettings < ActiveRecord::Migration
  def self.up
    create_table :sitesettings do |t|
		t.boolean :online
		t.time :notification_time
		t.boolean :notification_monday
		t.boolean :notification_tuesday
		t.boolean :notification_wednesday
		t.boolean :notification_thursday
		t.boolean :notification_friday
		t.boolean :notification_saturday
		t.boolean :notification_sunday
		t.time :email_tme
		t.boolean :email_monday
		t.boolean :email_tuesday
		t.boolean :email_wednesday
		t.boolean :email_thursday
		t.boolean :email_friday
		t.boolean :email_saturday
		t.boolean :email_sunday
		t.time :sms_time
		t.boolean :sms_monday
		t.boolean :sms_tuesday
		t.boolean :sms_wednesday
		t.boolean :sms_thursday
		t.boolean :sms_friday
		t.boolean :sms_saturday
		t.boolean :sms_sunday
      t.timestamps
    end
  end

  def self.down
    drop_table :sitesettings
  end
end
