class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.column :follower_id,               :integer
      t.column :notification,              :string
      t.column :details,                   :text
      t.column :delivered_at,              :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
