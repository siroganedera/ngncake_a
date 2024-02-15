class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      #注文id
      t.integer :order_id
      #商品id
      t.integer :item_id
      #購入時価格
      t.integer :price
      #数量
      t.integer :amount
      #製造ステータス、初期値を０へ
      t.integer :making_status, default: 0
      #作成、更新日時
      t.timestamps
    end
  end
end
