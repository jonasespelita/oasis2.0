class AddFkChanges < ActiveRecord::Migration
  def self.up
  	execute "ALTER TABLE changes ADD CONSTRAINT fk_changes_to_admin FOREIGN KEY (admin_id) REFERENCES admins (id);"
  end

  def self.down
  end
end
