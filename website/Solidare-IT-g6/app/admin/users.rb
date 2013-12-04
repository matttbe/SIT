ActiveAdmin.register User, :as => "Users" do

  config.batch_actions = true

  filter :name
  filter :id_ok

  member_action :valid_user, :method => :get do
    user = User.find(params[:id])
    if !user.nil?
    user.id_ok=true
    user.save
    Notifier.admin_validated(user).deliver
    end
    respond_to do |format|
      format.html{ redirect_to request.referer}
    end
  end

  index do
    selectable_column
    id_column
    column("State")   {|customer|
      if customer.id_ok
        status_tag("With a ID", :warning)
      else
        status_tag("no ID", :error)
      end
    }
    column :name
    column :firstname
    column :email
    column :karma
  end

end

ActiveAdmin.register User, :as => "Managed_users" , namespace: :organisation_manage  do

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :firstname
      
    end
    f.inputs "Organisation" do
      f.collection_select :managed_org_id, Organisation.where("creator_id=:id",:id=>current_user.id), :id, :name
    end
    #f.inputs "Organisation" do
    #  f.collection_select :organisation_id, Organisation.where("creator_id=:id",:id=>current_user.id), :id, :name
    #end
    f.actions
  end

  controller do
    def create
      @user=User.new(permitted_params)
      @coworker=Coworker.where(:user_id=>current_user.id).where(:organisation_id=>@user.managed_org_id).first
      #coworker_id
      @user.coworker_id=@coworker.id
      @user.password = @user.name+@user.firstname+@user.name
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...8).map{ o[rand(o.length)] }.join
      @user.email= @user.name + @user.firstname + string + '@solidateit.com'
      @user.inscription_ok=true
      @user.save
    end
    def permitted_params
      params.permit(:managed_users => [:name, :firstname])
    end
  end

end
