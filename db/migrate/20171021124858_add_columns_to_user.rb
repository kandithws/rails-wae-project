class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cell_phone_no, :string
    add_column :users, :admin, :boolean
    add_column :users, :banned, :boolean
    add_column :users, :sync_gplus_profile_pic, :boolean
    add_column :users, :profile_pic_path, :string
    add_column :users, :profession, :string
  end
end
