class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :introduction, null: false
      t.integer :price, null: false
      t.integer :genre_id
      t.boolean :is_active, default: true
      t.boolean :item_status, null:false, default: true

      t.timestamps
    end
  end
end
