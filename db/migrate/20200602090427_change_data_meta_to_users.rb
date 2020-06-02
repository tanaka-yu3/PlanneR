class ChangeDataMetaToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :meta, :text
  end
end
