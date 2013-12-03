ActiveAdmin.register Coworker, :as => "Coworkers", namespace: :organisation_manage  do
  config.clear_action_items!
  #form :partial =>"form"

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
    
  end


  member_action :organisation do
    @organisation = Organisation.find(params[:id])
  end

end

