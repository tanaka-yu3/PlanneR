class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :item
      t.references :user
      t.integer :amount
      t.integer :pay
      t.date :first_day
      t.date :last_day
      t.timestamps
    end
  end
end
