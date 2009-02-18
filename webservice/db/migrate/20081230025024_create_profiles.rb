class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :idNo
      t.string :familyName
      t.string :givenName
      t.string :middleName
      t.string :course
      t.string :gender
      t.integer :yearLevel
      t.string :college
      t.string :address
      t.string :email
      t.string :mobileNumber
      t.string :fatherName
      t.string :motherName
      t.string :guardianName
      t.string :relationshipToGuardian

      #t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
