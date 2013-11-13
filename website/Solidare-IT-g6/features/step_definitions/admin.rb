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
  assert page.has_content?("Users to confirm")
  assert page.has_content?("Validate")
end

Then /^I should validated a non validated user$/ do
  @u = User.where(:email => "eddy@savoir.congo").first
  assert page.has_content?(@u.email)
  click_link("Validate")
end

Then /^I din't see it again on the dashboard$/ do
  @u = User.where(:email => "eddy@savoir.congo").first
  assert !page.has_content?(@u.email)
end
