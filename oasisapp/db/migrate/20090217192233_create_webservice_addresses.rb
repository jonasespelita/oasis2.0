class CreateWebserviceAddresses < ActiveRecord::Migration
  def self.up
    create_table :webservice_addresses do |t|
    	t.string :name
		t.text :address
      t.timestamps
    end
  end

  def self.down
    drop_table :webservice_addresses
  end
end
