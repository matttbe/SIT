##THEN##
Then(/^I see the create organisation button$/) do
  assert page.has_content?("Create an organisation")
end

Then(/^I see I joined this organisation$/) do
  assert page.has_content?("Go to dashboard")
end


##WHEN##
When(/^I fill the organisation form$/) do
  fill_in "organisation_name", :with => "Enfants perdus du Pérou"
end

