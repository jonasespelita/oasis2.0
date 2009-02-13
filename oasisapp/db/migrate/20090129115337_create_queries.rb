class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
		t.string :subject, :null => false
		t.text :message
		t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
