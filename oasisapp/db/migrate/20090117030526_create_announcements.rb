class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
    	t.timestamp :date_time, :null => false
    	t.text :announcement, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
