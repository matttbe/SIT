ActiveAdmin.register_page "Dashboard" do

#menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
  #  div :class => "blank_slate_container", :id => "dashboard_default_message" do
  #    span :class => "blank_slate" do
  #      span I18n.t("active_admin.dashboard_welcome.welcome")
  #      small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #    end
  #  end

    columns do

      column do
        panel "Users to confirm" do
          table_for User.where(:id_ok => false).limit(10).each do |customer|
            column("State")   {|customer|
              if customer.id_ok
                status_tag("With a ID", :warning)
              else
                status_tag("no ID", :error)
              end
            }
            column("Name")   {|customer| customer.all_name}
            column("Email")  {|customer| customer.email}
            column("")       {|customer| link_to "Validate", valid_user_admin_user_path(customer)}
          end
        end
      end

      column do
        panel "Report problem (irly ? :p)" do
          para "to do"
        end
      end
    end

    columns do

      column do
        panel "Organisation to confirm" do
          table_for Organisation.where(:validated => false).limit(10).each do |customer|
            column("Name")   {|customer| customer.name}
            column("")       {|customer| link_to "Validate", valid_organisation_admin_organisation_path(customer)}
          end
        end
      end

      column do
        panel "Report problem (irly ? :p)" do
          para "to do"
        end
      end
    end

  # Here is an example of a simple dashboard with columns and panels.
  #
  # columns do
  #   column do
  #     panel "Recent Posts" do
  #       ul do
  #         Post.recent(5).map do |post|
  #           li link_to(post.title, admin_post_path(post))
  #         end
  #       end
  #     end
  #   end

  #   column do
  #     panel "Info" do
  #       para "Welcome to ActiveAdmin."
  #     end
  #   end
  # end
  end # content

end
