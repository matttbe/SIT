ActiveAdmin.register Organisation, :as => "Organisation" do

  member_action :valid_organisation, :method => :get do
    orga = Organisation.find(params[:id])
    if !orga.nil?
    orga.validated=true
    orga.save
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
