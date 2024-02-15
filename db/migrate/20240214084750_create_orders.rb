class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      #会員id
      t.integer :customer_id
      #配送先郵便番号
      t.string :postal_code
      #配送先住所
      t.string :address
      #配送先宛名
      t.string :name
      #送料
      t.integer :shipping_cost
      #請求金額
      t.integer :total_payment
      #支払方法（enumで管理）
      t.integer :payment_method
      #注文ステータス（初期値を０へ）
      t.integer :status, default: 0
      #作成、更新日時
      t.timestamps
    end
  end
end
