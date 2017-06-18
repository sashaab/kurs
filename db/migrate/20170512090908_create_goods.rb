class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :title, null: false, limit:100
      t.text :short_description, null: false, limit:100
      t.text :full_description, null: false, limit:1000
      t.integer :list_id_images, null: false
      t.float :base_price, null: false, numericality: {greater_than_or_equal_to: 1}
      t.float :current_price, null: false, numericality: {greater_than_or_equal_to: 1}
      t.integer :quantity_in_stock, null: false, numericality: {greater_than_or_equal_to: 0, only_integer: true}
      t.integer :article, null: false
      t.integer :minimum_quantity, null: false, numericality: {greater_than_or_equal_to: 1, only_integer: true}

      t.index [:title], unique: true
      t.index [:article], unique: true

      t.timestamps null: false
    end
  end
end
