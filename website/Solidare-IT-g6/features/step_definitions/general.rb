When(/^I click on the (.*) button$/)do |button|
  click_button button
end

When(/^I click on the (.*) link$/)do |link|
  click_link link
end



Then(/^show me the page$/)do
  save_and_open_page
end

Then(/^I should be on root page$/)do
    assert page.has_content?("Trollol")
end

Then(/^I should see a missing (.*) message$/)do |blank|
  assert page.has_content?(blank||" can't be blank")
end

Then(/^I see a (.*) message$/)do |message|
  assert page.has_content?(message)
end

