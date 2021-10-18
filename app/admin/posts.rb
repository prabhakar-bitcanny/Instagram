ActiveAdmin.register Post do
  permit_params :user_id, :caption
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :caption, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:caption, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :caption
  # filter :current_sign_in_at
  # filter :sign_in_count
  filter :created_at
  filter :user

  show do
    attributes_table do
      row :caption
      # row :images
      row :user_id
    end

    panel "Contents" do
      table_for post.postcomments do
        # column :number
        column :content
        column :user_id
        # column :page
      end
    end
    # active_admin_comments
  end
end
