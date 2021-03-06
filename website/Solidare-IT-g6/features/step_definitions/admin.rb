### GIVEN ###
### WHEN ###
When /^I go to admin page$/ do
  visit '/admin'
end

### THEN ###
Then /^I see the admin link$/ do
  assert page.has_content?("Admin")
end

Then /^I not see the admin link$/ do
  assert !page.has_content?("Admin")
end

Then /^I should see the Dashboard$/ do
  assert page.has_content?("Dashboard")
end

Then /^I should see non validated user$/ do
  assert page.has_content?("Users to confirm")
  assert page.has_button?("Validate")
end

Then /^I should validated a non validated user$/ do
  @u = User.where(:email => "eddy@savoir.congo").first
  assert page.has_content?(@u.email)
  click_button("Validate")
end

Then /^I din't see it again on the dashboard$/ do
  assert !page.has_button?("Validate")
end

Then /^I see an error message because I'm not authorized to do that$/ do
  assert page.has_content?("You are not authorized to perform this action.")
end