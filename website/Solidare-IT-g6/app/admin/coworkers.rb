ActiveAdmin.register Coworker, :as => "Coworkers", namespace: :organisation_manage  do
  config.clear_action_items!
  menu false

  show :title => "Manage coworker" do
    render 'show.html.arb'
  end

  form do |f|
    f.inputs "User" do
      f.collection_select :user_id, User.all, :id, :all_name
    end
    f.inputs "Organisation" do
      f.collection_select :organisation_id, Organisation.where("creator_id=:id",:id=>current_user.id), :id, :name
    end
    f.actions
  end


  controller do
    def permitted_params
      params.permit(:coworkers => [:organisation_id, :user_id])
    end
  end

  member_action :remove_coworker, :method => :get do
    coworker = Coworker.find(params[:id])
    
    if !coworker.nil?
      coworker.destroy
    #Notifier.admin_validated(user).deliver
    end
    respond_to do |format|
      format.html{ redirect_to request.referer}
    end
  end

  index do
          table_for Coworker.joins(:organisation).where("organisations.creator_id=:id", :id=>current_user.id).each do |coworker|
    
            column("Name")   {|coworker| link_to coworker.user.all_name, organisation_manage_coworker_path(coworker)}
            column("Email")  {|coworker| coworker.user.email}
            column("Organisation")  {|coworker| coworker.organisation.name}
          end
  end

  sidebar "Actions", :only=>:show do
    button_to "Add a managed user", new_managed_user_for_coworker_path(coworkers.organisation.id,coworkers.id), :method=> :get
  end


  member_action :organisation do
    @organisation = Organisation.find(params[:id])
  end

end


