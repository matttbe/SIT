ActiveAdmin.register User do

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :superadmin, :as => :boolean, :label => "Super Administrator"
    end
    f.actions
  end

  create_or_edit = Proc.new {
    @user            = User.find_or_create_by_id(params[:id])
    if not params[:user][:superadmin].nil?
      @user.superadmin = params[:user][:superadmin]
    end
    @user.email = params[:user][:email]
    if not params[:user][:password].nil? and not params[:user][:password].empty? and params[:user][:password] == params[:user][:password_confirmation]
      user.password = params[:user][:password]
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end