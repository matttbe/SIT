Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should be on root page$/ do
    assert page.has_content?("This is the home page!!!")
end


