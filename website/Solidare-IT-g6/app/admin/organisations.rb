ActiveAdmin.register Organisation, :as => "Organisations" do

  member_action :valid_organisation, :method => :get do
    orga = Organisation.find(params[:id])
    if !orga.nil?
      orga.validated = true
      orga.save
    end
    respond_to do |format|
      format.html{ redirect_to request.referer}
    end
  end

  member_action :add_coworker, :method => :post do
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
    selectable_column
    column("name") {|customer|
      if customer.validated
        status_tag(customer.name, :green)
      else
        status_tag(customer.name, :error)
      end
    }
  end
end

ActiveAdmin.register Organisation, :as => "Organisations", namespace: :organisation_manage  do
  config.clear_action_items!
  menu false
  actions :index
  
  index do
    table_for current_user.own_organisations.each do |organisation|
      column :name
      column("Coworkers"){|organisation| link_to organisation.coworkers.size, organisation_organisation_manage_coworker_path(organisation)}
      column(){}
    end
  end
  
end
