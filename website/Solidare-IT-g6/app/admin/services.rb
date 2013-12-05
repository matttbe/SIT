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
  form do |f|
    #f.inputs "User" do
    #  f.input :name
    #  f.input :firstname

    #end
    f.inputs "Service" do
      f.input :title
      f.input :description, :input_html=> {:class => "autogrow"}
      f.input :date_start, :as => :datepicker
    end
  end

end
