class AddColumnPasswordToIdentities < ActiveRecord::Migration[5.2]
  def change
    add_column :identities, :password, :string
  end
end