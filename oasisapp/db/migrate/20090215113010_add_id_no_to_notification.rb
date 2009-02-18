class AddIdNoToNotification < ActiveRecord::Migration
  def self.up
    add_column :notifications, :idno, :integer
  end

  def self.down
    remove_column :notifications, :idno
  end
end
