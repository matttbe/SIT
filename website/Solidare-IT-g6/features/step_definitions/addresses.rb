def create_address_user
  @address ||= { :street =>"rue du savoir", :number=>'12', :password_confirmation=>'iloveponcin', :name =>"Maitre", :firstname => "Ciel", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>true }
end

### THEN ###
Then /^I can not see the manage my adresses link$/ do
  assert !page.has_content?("Manage my addresses")
end

Then /^I can see the manage my adresses link$/ do
  assert page.has_content?("Manage my addresses")
end

Then /^I can see the add adresses link$/ do
  assert page.has_content?("New address")
end
