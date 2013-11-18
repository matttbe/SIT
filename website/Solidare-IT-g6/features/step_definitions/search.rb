### WHEN ###
When /^I do a search of (.*) words$/ do |search|
  fill_in "q", :with => search
end
