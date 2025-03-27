class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :address_line
      t.string :building_name
      t.string :phone_number
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
