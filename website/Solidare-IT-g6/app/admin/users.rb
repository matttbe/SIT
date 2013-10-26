ActiveAdmin.register User, :as => "Users" do

	config.batch_actions = true

  	filter :name
	filter :id_ok


	index do
	    selectable_column
	    id_column
	    column :name
	    column :firstname
	    column :email
	    column :karma
	    default_actions
	end


end
