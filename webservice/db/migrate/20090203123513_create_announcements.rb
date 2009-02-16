class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.date :eventDate
      t.string :event
      t.string :memoDetail

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end
