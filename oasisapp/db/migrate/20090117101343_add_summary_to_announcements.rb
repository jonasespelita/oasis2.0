class AddSummaryToAnnouncements < ActiveRecord::Migration
  def self.up
  	add_column :announcements, :summary, :text
  end

  def self.down
  	remove_column :announcements, :summary
  end
end
