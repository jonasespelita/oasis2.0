class AddToSiteSettings < ActiveRecord::Migration
  def self.up
  	add_column :sitesettings, :semester, :text
  	add_column :sitesettings, :name, :text
  end

  def self.down
  	remove_column :sitesettings, :semester
  	remove_column :sitesettings, :name
  end
end
