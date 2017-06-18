class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :client, index: true, foreign_key: true, null:false
      t.integer :order_number, null: false
      t.string :payment_method, null: false
      t.string :delivery_method, null: false
      t.string :list_products
      t.float :cost_goods, null: false, numericality: {greater_than_or_equal_to: 1}
      t.float :total_cost, null: false, numericality: {greater_than_or_equal_to: 1}
      t.date :order_date, null: false

      t.timestamps null: false
    end
  end
end
