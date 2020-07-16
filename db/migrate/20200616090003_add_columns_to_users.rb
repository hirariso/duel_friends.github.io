class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
  add_column :users,:duel_id,:string
  add_column :users,:profile,:text
  end
end
