ActiveAdmin.register Service, :as => "Service" do

  index do
    selectable_column
    column("Title")   {|service|
      if service.matching_service.nil?
        status_tag(service.title, :default)
      else
        status_tag(service.title, :green)
      end
    }
    column :description
  end

end

ActiveAdmin.register Service, :as => "Managed service" , namespace: :organisation_manage  do
  menu false
  form do |f|
    #f.inputs "User" do
    #  f.input :name
    #  f.input :firstname

    #end
    f.inputs "Service" do
      f.input :title
      f.input :description, :input_html=> {:class => "autogrow"}
      f.input :date_start, :as => :datepicker
      f.input :date_end, :as => :datepicker
    end
    f.inputs "Category" do
      f.collection_select :category_id, Category.all, :id, :title
    end
    f.inputs "Pictures" do
      f.input :photo, :as=>:file, :hint=> f.template.image_tag(f.object.photo.url(:thumb))
    end
    f.inputs "Managed user" do
      if params.has_key?(:id_managed)
        f.collection_select :creator_id, User.where("id=:id",:id=>params[:id_managed]), :id, :all_name
      else
        @co=User.joins(:coworker).where("coworkers.user_id=:id", :id=>current_user.id)
        f.collection_select :creator_id, @co, :id, :all_name
      end
    end
    f.actions
  end

end