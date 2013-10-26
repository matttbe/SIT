ActiveAdmin.register User, :as => "Customer" do

	config.batch_actions = true

  	filter :username


end
