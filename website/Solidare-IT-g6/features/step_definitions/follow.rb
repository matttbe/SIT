### THEN ###

Then(/^I should see a follow link$/) do
  assert page.has_content?("Follow")
end

Then(/^I can not see the unfollow link$/) do
  assert !page.has_content?("Unfollow")
end

Then(/^I should see a unfollow link$/) do
  assert page.has_content?("Unfollow")
end

Then(/^I can not see the follow link$/) do
  assert !page.has_content?("Follow")
end