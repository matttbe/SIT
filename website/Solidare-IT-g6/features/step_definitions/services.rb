def create_service
  @serviceC ||= { :title=>"Livre",:description => "vente livre congolexicomatisation", :date_start => 'Mon, 28 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => 0}
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



### THEN ###

Then(/^I see a service$/) do
  assert page.has_content?(@serviceC[:title])
end

