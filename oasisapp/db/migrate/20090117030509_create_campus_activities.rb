class CreateCampusActivities < ActiveRecord::Migration
  def self.up
    create_table :campus_activities do |t|
    	t.timestamp :date, :null => false
    	t.text :activity, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :campus_activities
  end
end
