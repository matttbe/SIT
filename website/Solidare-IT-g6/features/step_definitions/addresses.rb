def create_address_user
  @addr ||= { :street =>"rue aux fleurs", :number=>'8', :postal_code=>'1341', :city =>"Céroux", :country => "Belgium"}
end

def add_my_address
    create_address_user
    @u ||= Address.where(:street => @addr[:street]).first
    @u.destroy unless @u.nil?
    find_user
    @addr[:user_id]=@user.id
    @address = Address.create!(@addr)
end

def fill_form_address
  fill_in "address_street", :with => @addr[:street]
  fill_in "address_number", :with => @addr[:number]
  fill_in "address_postal_code", :with => @addr[:postal_code]
  fill_in "address_city", :with => @addr[:city]
  select(@addr[:country], :from=>  "address_country")

end

### WHEN ###
When(/^I fill the address form$/) do
  create_address_user
  fill_form_address
end

When(/^I fill a wrong number$/) do
  fill_in "address_number", :with => 'notNumber'
end

When(/^I have already given a address$/) do
  add_my_address
end

When(/^I fill a wrong postal code$/) do
  fill_in "address_postal_code", :with => 'notNumber'
end

When(/^I click on the edit link of the first address in the list$/) do
  visit '/address/'+@address.id.to_s+'/edit'  
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
  assert page.has_content?(@addr[:street])
end

Then /^I not see my address$/ do
  assert !page.has_content?(@addr[:street])
end


