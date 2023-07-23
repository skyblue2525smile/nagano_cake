class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :order_id, null: false, foreign_key: true
      t.references :item_id, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :purchase_price, null: false
      t.boolean :making_status, null: false, default: true

      t.timestamps
    end
  end
end
