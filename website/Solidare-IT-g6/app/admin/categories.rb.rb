ActiveAdmin.register Category, :as => "Category" do

  controller do
    def permitted_params
      params.permit(:category => [:parent,:title,:text, :date_start, :date_end,:is_demand, :photo, :creator_id])
    end
  end
end
