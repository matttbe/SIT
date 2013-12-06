### GIVEN ###
### WHEN ###

### THEN ###

Then(/^I should see a share link$/) do
  assert page.has_content?("Share it !")
end
