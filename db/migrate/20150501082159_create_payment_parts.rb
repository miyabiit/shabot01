class CreatePaymentParts < ActiveRecord::Migration
  def self.up
    create_table :payment_parts do |t|
      t.integer :payment_header_id
      t.integer :item_id
      t.float :amount
      
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_parts
  end
end