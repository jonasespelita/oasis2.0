class AddNewToNotification < ActiveRecord::Migration
  def self.up
    add_column :notifications, :new, :boolean
  end

  def self.down
    remove_column :notifications, :new
  end
end
