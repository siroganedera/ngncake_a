class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.integer :customer_id
      t.string :post_code
      t.text :address
      t.string :recipient
      
      t.timestamps null: false
    end
  end
end
