class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user
      t.references :genre
      t.string :name
      t.text :text
      t.integer :price
      t.string :video
      t.string :address
      t.date :start_day
      t.date :finish_day
      t.integer :item_status ,default: false
      t.integer :total
      t.timestamps
    end
  end
end
