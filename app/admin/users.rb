ActiveAdmin.register User do

  permit_params :name, :user_name, :email, :phone_no, :password, :password_confirmation
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :user_name, :phone_no, :bio, :profile_pic
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :user_name, :phone_no, :bio, :profile_pic]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :name
    column :user_name
    column :phone_no
    column :email
    column :bio
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at

    actions
  end

  filter :email
  filter :phone_no
  # filter :current_sign_in_at
  # filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :name
      row :user_name
      row :email
      row :bio
      row :phone_no
    end
    # active_admin_comments
  end


  form do |f|
    f.inputs do
      f.input :name
      f.input :user_name
      f.input :phone_no
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
