ActiveAdmin.register User, :as => "Users" do

  config.batch_actions = true

  filter :name
  filter :id_ok

  member_action :valid_user, :method => :get do
    user = User.find(params[:id])
    if !user.nil?
    user.id_ok=true
    user.save
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
