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
