class CreateChanges < ActiveRecord::Migration
  def self.up
    create_table :changes do |t|
    	t.text :change_made, :null => false
		t.string :ip_add
		t.integer :admin_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :changes
  end
end
