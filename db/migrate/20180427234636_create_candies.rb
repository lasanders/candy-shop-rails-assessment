class CreateCandies < ActiveRecord::Migration[5.2]
  def change
    create_table :candies do |t|
      t.string :name
      t.string :taste
      t.integer :cost
      t.integer :appetite
      t.integer :count
      t.timestamps
    end
  end
end
