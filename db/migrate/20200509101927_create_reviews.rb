class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :item
      t.text :text
      t.string :rate
      t.timestamps
    end
  end
end
