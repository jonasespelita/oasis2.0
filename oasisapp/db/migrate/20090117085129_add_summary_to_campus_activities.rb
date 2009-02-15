class AddSummaryToCampusActivities < ActiveRecord::Migration
  def self.up
  	add_column :campus_activities, :summary, :text
  end

  def self.down
  	remove_column :campus_activities, :summary
  end
end
