### WHEN ###
When /^I do a search of (.*) words in (.*)$/ do |search,type|
  fill_in "q", :with => search
   select(type, :from=> "type_q")
end
