def current_path
  URI.parse(current_url).path
end

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
  current_path == '/'
end

Then(/^I should be on the url (.+?)$/)do |url|
  current_path == url
end

Then(/^I should see a missing (.*) message$/)do |blank|
  assert page.has_content?(blank||" can't be blank")
end

Then(/^I see a (.*) message$/)do |message|
  assert page.has_content?(message)
end

