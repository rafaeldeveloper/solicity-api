class AddAdtionalFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :site, :string
    add_column :users, :url_image, :string
    add_column :users, :phone, :string
    add_column :users, :cpf, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
