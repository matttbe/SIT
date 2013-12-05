### WHEN ###
When /^I do a search of (.*) words in (.*)$/ do |search,type|
  find_by_id('q').set(search)
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
  find_by_id('q').set("")
  if(type=='Demand')
    check('demand_cbox')
  elsif(type=='Offer')
    check('offer_cbox')
  else
    check('demand_cbox')
    check('offer_cbox')
  end
end
