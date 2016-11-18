class AddAppIdToUsers < ActiveRecord::Migration[5.0]
  def change
  	 add_column :users, :app_id, :string, limit: 240
  end
end
