def add_follower
  find_admin_user
  find_user
  @service=Service.where("creator_id=:id", :id=>@user.id).first
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
  print(@admin_user.id)
  print(@service.id)
  @follow=Follower.new
  @follow[:service_id]=@service.id
  @follow[:user_id]=@admin_user.id
  @follow.save
    
end

### WHEN ###
When /^I visit the page of the services I follow$/ do
   visit 'user/following_services'
end

When /^Some users follow my service$/ do
  add_follower
end

### THEN ###

Then(/^I should see a follow link$/) do
  assert page.has_link?("Follow")
end

Then(/^I can not see the unfollow link$/) do
  assert !page.has_link?("Unfollow")
end

Then(/^I should see a unfollow link$/) do
  assert page.has_link?("Unfollow")
end

Then(/^I can not see the follow link$/) do
  assert !page.has_link?("Follow")
end

Then(/^I can see the followers of my service$/) do
  show_page
end

Then(/^I should see an accept link$/) do
  assert page.has_link?("Accept")
end

