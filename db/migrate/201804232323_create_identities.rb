class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :name
      t.string :provider
      t.string :uid
      t.string :email
      t.timestamps
    end
  end
end