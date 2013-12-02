ActiveAdmin.register Coworker, :as => "Coworker", namespace: :organisation_manage  do
  config.clear_action_items!

  index do
    
  end

  member_action :organisation do
    @organisation = Organisation.find(params[:id])
  end

end