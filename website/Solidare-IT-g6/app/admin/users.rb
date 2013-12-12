ActiveAdmin.register User, :as => "Users" do

  config.batch_actions = true

  filter :name
  filter :id_ok

  member_action :valid_user, :method => :get do
    user = User.find(params[:id])
    if !user.nil?
    user.id_ok=true
    user.save
    user.add_badge(1)
    Notifier.admin_validated(user).deliver
    end
    respond_to do |format|
      format.html{ redirect_to request.referer}
    end
  end

  index do
    selectable_column
    column("ID")   {|user|
      if user.has_role? "superadmin"
        status_tag(user.id, :green)
      else
        status_tag(user.id, :default)
      end
    }
    column :name
    column :firstname
    column :birthdate
    column :email
  end

end

ActiveAdmin.register User, :as => "Managed user" , namespace: :organisation_manage  do
  menu false

  form do |f|
    f.inputs "User" do
      f.input :name
      f.input :firstname
      
    end
    f.inputs "Organisation" do
      if params.has_key?(:id_orga)
        f.collection_select :managed_org_id, Organisation.where("creator_id=:id",:id=>current_user.id).where("id=:id",:id=>params[:id_orga]), :id, :name
      else
        f.collection_select :managed_org_id, Organisation.where("creator_id=:id",:id=>current_user.id), :id, :name
      end
    end

    f.inputs "Coworker" do
       if params.has_key?(:id_coworker)
        @co=Coworker.where("id=:id",:id=>params[:id_coworker]).first
        f.collection_select :coworker_id, User.where(:id=>@co.user_id), :id, :all_name
       else
         @co=User.joins(:coworkers).includes(:organisations).where("organisations.creator_id=:id", :id=> current_user.id)
        f.collection_select :coworker_id, @co, :id, :all_name
       end
    end
    #f.inputs "Organisation" do
    #  f.collection_select :organisation_id, Organisation.where("creator_id=:id",:id=>current_user.id), :id, :name
    #end
    f.actions
  end

  


  controller do

    def index
      render :partial =>'all_managed_users.html.arb'
    end
    
    def destroy
      @user=User.find(params[:id])
      @user.destroy
      respond_to do |format|
          format.html { redirect_to request.referer, notice: 'You have successfully deleted managed user.' }
        end
    end

    def create
      @user=User.new(new_managed_params)
      @user.birthdate='Mon, 18 Jun 1990 15:00:00 UTC +00:00'
      #coworker_id
      @coworker=Coworker.where(:user_id=>new_managed_params[:coworker_id]).where(:organisation_id=>new_managed_params[:managed_org_id]).first
      @user.coworker_id=@coworker.id
      @user.password = @user.name+@user.firstname+@user.name
      o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...8).map{ o[rand(o.length)] }.join
      @user.email= @user.name + @user.firstname + string + '@solidateit.com'
      @user.inscription_ok=true
      @user.managed_by_organisation=true
      if @user.save
        respond_to do |format|
          format.html { redirect_to organisation_manage_coworker_path(@user.coworker_id), notice: 'You have successfully created a new managed user.' }
        end
      else
        respond_to do |format|
          format.html { redirect_to organisation_manage_coworker_path(@user.coworker_id), notice: 'merdoum' }
        end
      end
    end
    def new_managed_params
      params.require(:manageduser).permit(:name,:firstname,:managed_org_id, :coworker_id)
    end
    def permitted_params
      params.permit(:users => [:name, :firstname])
    end
  end

end

ActiveAdmin.register_page "Managed Users", namespace: :organisation_manage  do

  content do
    render :partial =>'all_managed_users.html.arb'
  end
end