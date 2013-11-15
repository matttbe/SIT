Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should be on root page$/ do
    assert page.has_content?("This is the home page!!!")
end

Then(/^I should see a missing (.*) message$/) do |blank|
  assert page.has_content?(blank||" can't be blank")
end

