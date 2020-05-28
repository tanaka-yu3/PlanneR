class AddorderStatusToorder < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders ,:order_status ,:integer ,default: false
  end
end
