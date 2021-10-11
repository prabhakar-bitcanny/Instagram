class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :user_name, :string
    # add_column :users, :email, :string
    add_column :users, :phone_no, :integer
    add_column :users, :bio, :text
    add_column :users, :profile_pic, :string

  end
end
