def create_address_user
  @address ||= { :street =>"rue du savoir", :number=>'12', :postal_code=>'1234', :city =>"Kinshasa", :country => "Canada" }
end

def fill_form_address
  fill_in "address_street", :with => @address[:street]
  fill_in "address_number", :with => @address[:number]
  fill_in "address_postal_code", :with => @address[:postal_code]
  fill_in "address_city", :with => @address[:city]
  select(@address[:country], :from=>  "address_country")

end

### WHEN ###
When(/^I fill the address form$/) do
  create_address_user
  fill_form_address
end

When(/^I fill a wrong number$/) do
  fill_in "address_number", :with => 'notNumber'
end

When(/^I fill a wrong postal code$/) do
  fill_in "address_postal_code", :with => 'notNumber'
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

Then /^I see my address$/ do
  assert page.has_content?(@address[:street])
end

Then /^I not see my address$/ do
  assert !page.has_content?(@address[:street])
end
