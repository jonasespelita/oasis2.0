class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
    	t.string :username, :null => false, :limit => 40
    	t.string :hashed_password, :null => false
      t.string :salt, :null => false
      t.string :last_name, :null => false
      t.string :first_name, :null => false
      t.string :position, :null => false
      t.boolean :active, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
