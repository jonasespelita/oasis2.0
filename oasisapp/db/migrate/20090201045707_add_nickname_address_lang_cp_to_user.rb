class AddNicknameAddressLangCpToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string
    add_column :users, :cp_number, :string
    add_column :users, :lang_pref, :integer
    add_column :users, :nickname, :string
  end

  def self.down
     remove_column :users, :address
     remove_column :users, :cp_number
     remove_column :users, :lang_pref
     remove_column :users, :nickname
  end
end
