class AddEmailAndVisitToAdmin < ActiveRecord::Migration
  def self.up
  	add_column :admins, :email, :text
  	add_column :admins, :last_visit, :timestamp
  end

  def self.down
  remove_column :admins, :email
  remove_column :admins, :last_visit
  end
end
