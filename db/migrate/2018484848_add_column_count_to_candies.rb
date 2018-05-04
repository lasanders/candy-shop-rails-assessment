class AddColumnCountToCandies < ActiveRecord::Migration[5.2]
  def change
    add_column :candies, :count, :integer
  end
end