##THEN##
Then(/^I see the create a group button$/) do
  assert page.has_content?("Create a group")
end

##WHEN##
When(/^I fill the group form$/) do
  fill_in "group_name", :with => "One direction forever"
end
