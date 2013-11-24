### WHEN ###
When /^I do a search of (.*) words in (.*)$/ do |search,type|
  fill_in "q", :with => search
  if(type=='Demand')
    check('demand_cbox')
  elsif(type=='Offer')
    check('offer_cbox')
  else
    check('demand_cbox')
    check('offer_cbox')
  end
end
When /^I do a search without any words in (.*)$/ do |type|
  fill_in "q", :with => ""
  if(type=='Demand')
    check('demand_cbox')
  elsif(type=='Offer')
    check('offer_cbox')
  else
    check('demand_cbox')
    check('offer_cbox')
  end
end
