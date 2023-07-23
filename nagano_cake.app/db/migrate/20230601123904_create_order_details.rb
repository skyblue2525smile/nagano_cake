class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :quantity, null: false
      t.integer :purchase_price, null: false
      t.integer :making_status, null: false, default: true

      t.timestamps
    end
  end
end
