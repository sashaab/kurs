class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false, limit:20
      t.string :phone, null: false, limit:20
      t.string :address, null: false, limit:20
      t.string :email, null: false, limit:20

      t.index [:phone], unique: true
      t.index [:email], unique: true

      t.timestamps null: false
    end
  end
end
