##THEN##
Then(/^I see the create organisation button$/) do
  assert page.has_content?("Create an organisation")
end

##WHEN##
When(/^I fill the organisation form$/) do
  fill_in "organisation_name", :with => "Enfants perdus du Pérou"
end
