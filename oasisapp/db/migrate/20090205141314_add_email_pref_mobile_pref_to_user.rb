class AddEmailPrefMobilePrefToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email_pref, :boolean
    add_column :users, :mobile_pref, :boolean
  end

  def self.down
    remove_column :users, :mobile_pref
    remove_column :users, :email_pref
  end
end
