class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :bank
      t.string :bank_branch
      t.string :category
      t.integer :ac_no
      
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end