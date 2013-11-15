def create_service
  @serviceC ||= { :title=>"Livre",:description => "vente livre congolexicomatisation", :date_start => 'Mon, 28 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => 0}
end

def new_service
  @serviceNew ||= { :title=>"Livre IA",:description => "vente livre IA", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => 0
}
end

def add_service
  create_user
  find_user
  create_service
  @serviceC[:creator_id]=@user.id
  @service = Service.create!(@serviceC)
end

### GIVEN ###
Given /^The database contains services$/ do
  add_service
end

### WHEN ###
When /^I go to the services list$/ do
  click_link "Services"
end

When(/^I go to the service_add page$/) do
  visit "services/new"
end

When /^I click on the add service link$/ do
  click_link "Add a service"
end

When(/^I fill the service form$/) do
  new_service
  fill_in "service_title", :with => @serviceNew[:title]
  fill_in "service_description", :with => @serviceNew[:description]
  select(2014, :from=> "service_date_start_1i")
  select('November', :from=>  "service_date_start_2i")
  select(10, :from=>  "service_date_start_3i")
  select(17, :from=>  "service_date_start_4i")
  select(27, :from=>  "service_date_start_5i")
  select(2014, :from=> "service_date_end_1i")
  select('December', :from=>  "service_date_end_2i")
  select(10, :from=>  "service_date_end_3i")
  select(17, :from=>  "service_date_end_4i")
  select(27, :from=>  "service_date_end_5i")
  click_button "Create service"
end



### THEN ###

Then(/^I see a service$/) do
  assert page.has_content?(@serviceC[:title])
end

Then(/^I see the add service button$/) do
  assert page.has_content?("Add a service")
end

Then(/^I see adding service message$/) do
  show_page
  assert page.has_content?("Service was successfully created.")
end

