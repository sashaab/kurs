class CreateGoodOrders < ActiveRecord::Migration
  def change
    create_table :good_orders do |t|
      t.references :good, index: true, foreign_key: true, null:false
      t.references :order, index: true, foreign_key: true, null:false
      t.integer :digit, null: false

      t.timestamps null: false
    end
  end
end
