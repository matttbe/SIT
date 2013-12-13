ActiveAdmin.register User do
  index do
    column :name
    column :firstname
    column :email
    column :birthdate
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    column :karma
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :name
      f.input :firstname
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :karma
      f.input :birthdate
    end
    f.actions
  end
  controller do
    def permitted_params
      params.permit(:users => [:name, :firstname, :email, :karma, :birthdate, :email, :password, :password_confirmation, :superadmin])
    end
  end
end
