def create_non_valide_user
  @visitor ||= { :email =>"eddy@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>false }
end

### GIVEN ###
### WHEN ###
When /^I go to admin page$/ do
  visit '/admin'
end

### THEN ###

Then /^I should see the Dashboard$/ do
  assert page.has_content?("Dashboard")
end

Then /^I should see non validated user$/ do
  save_and_open_page
  assert page.has_content?("Users to confirm")
end
