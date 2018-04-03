class CreateAnonymousUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :anonymous_users do |t|
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :profile_pic_path

      t.timestamps
    end
  end
end
