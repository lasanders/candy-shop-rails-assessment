class RemoveColumnTasteFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :taste, :integer
  end
end