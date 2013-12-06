def update_serv
  @visitor = nil
  create_admin_user
  find_admin_user
  sign_in
  @service = Service.where(:creator_id=>@admin.id).first
  visit '/services/'+@service.id.to_s+'/edit'
  click_button "Edit service"
  visit '/users/sign_out'
  @visitor = nil
  create_visitor
  sign_in
end

def accept_serv
  @service = Service.where(:creator_id=>@admin.id).first
  visit '/services/'+@service.id.to_s
  click_button "Accept"
end

def user_follow
 @service = Service.where(:creator_id=>@user.id).first
  #visit '/users/sign_out'
  @visitor = nil
  create_admin_user
  #find_admin_user
  sign_in
  visit '/services/'+@service.id.to_s
  click_link "Follow"
  visit '/users/sign_out'
  @visitor = nil
  create_visitor
  sign_in 
end

def user_unfollow
  @service = Service.where(:creator_id=>@user.id).first
  #visit '/users/sign_out'
  @visitor = nil
  create_admin_user
  #find_admin_user
  @follow = Follower.new
  @follow[:service_id] = @service.id
  @follow[:user_id] = @admin.id
  @follow.save
  sign_in
  visit '/services/'+@service.id.to_s
  click_link "Unfollow"
  visit '/users/sign_out'
  @visitor = nil
  create_visitor
  sign_in 
end

def user_accept
 @service = Service.where(:creator_id=>@user.id).first
  #visit '/users/sign_out'
  @visitor = nil
  create_admin_user
  #find_admin_user
  sign_in
  visit '/services/'+@service.id.to_s
  click_button "Accept"
  visit '/users/sign_out'
  @visitor = nil
  create_visitor
  sign_in
end

### GIVEN ###

Given /^a user click on the follow button of one of my service$/ do
  user_follow
end

Given /^a follower click on the unfollow button of one of my service$/ do
  user_unfollow
end

Given /^a user click on the accept button of one of my service$/ do
  user_accept
end

### WHEN ###

When /^I visit the notifications page$/ do   
  visit '/notifications'
  show_page
end

When /^The service is updated$/ do 
  update_serv 
end

When /^The service is accepted$/ do
  accept_serv
end

### THEN ###

Then(/^I should see a update notification$/) do
  assert page.has_content?("was eddited")  
end

Then(/^I should see a accept notification$/) do
   assert page.has_content?("was accepted") 
end

Then(/^I should see a follow notification$/) do
  assert page.has_content?("was followed")  
end

Then(/^I should see a unfollow notification$/) do
  assert page.has_content?("was unfollowed")  
end

Then(/^I should see a post notification$/) do
  assert page.has_content?("posted in")  
end

