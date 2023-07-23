class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer_id, null: false, foreign_key: true
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :mailling_label, null: false
      t.integer :postage, null: false
      t.integer :total_amount, null: false
      t.integer :method_of_payment, null: false
      t.boolean :order_status, null:false, default: true

      t.timestamps
    end
  end
end
