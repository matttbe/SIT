ActiveAdmin.register Coworker, :as => "Coworkers", namespace: :organisation_manage  do
  config.clear_action_items!

  member_action :remove_coworker, :method => :get, :param =>[:id, :id_coworker] do
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

