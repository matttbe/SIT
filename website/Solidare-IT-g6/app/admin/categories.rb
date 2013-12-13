ActiveAdmin.register Category, :as => "Category" do

  form do |f|
    f.inputs "Categories Details" do
      # f.input :parent_cat, :label => "Parent Category"
      f.input :parent, :as => :select, :collection => params.has_key?('id') ?
        Category.find(:all, :conditions => ["id != ?", params[:id]]) :
        Category.all
      f.input :title
      f.input :text
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit(:category => [:parent,:title,:text])
    end
  end
end
