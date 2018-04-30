class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.boolean :employee, default: false
      t.integer :cash
      t.integer :appetite

      t.timestamps
    end
  end
end
