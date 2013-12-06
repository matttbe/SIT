def create_group
    @groupX = {:name => "les fanatiques de savoir", :description => "Pcq on aime tous la nucléarité", :created_at => 'Mon, 28 oct 2014 15:00:00 UTC +00:00'}
end

def i_am_member 
   find_user
   #@group_member = GroupPost.new
   #@group_member[:user_id] = @user.id
   #@group_member[:group_id] = @group.id
   #@group_member.save
   visit '/group/'+@group.id.to_s
   click_link "Join"
end

def someone_post
  visit '/users/sign_out'
  @visitor = nil
  create_admin_user
  #find_admin_user
  sign_in
  visit '/group/'+@group.id.to_s
  click_link "Join"
  click_button "Add new post"
  visit '/users/sign_out'
  @visitor = nil
  create_visitor
  sign_in 
end

def add_group
  create_group
  @dl = Group.where("name LIKE :name", :name => @groupX[:name]).first
  @dl.destroy unless @dl.nil?
  @group = Group.create!(@groupX)
end

## GIVEN ##
Given (/^I am a member of a group$/) do
  i_am_member
end

Given /^the database contains groups$/ do
  add_group
end

## WHEN ##

When(/^I fill the group form$/) do
  fill_in "group[name]", :with => "One direction forever"
end

When(/^someone post a message on the group$/) do
  someone_post
end

When(/^I visit the page of a group$/) do
  @link="/group/"+@group.id.to_s
  visit @link
end

When(/^I visit the page of my group$/) do
  #find_user
  @groupC = GroupPost.where(:user_id=>@user.id).first
  @link="/group/"+@groupC.group_id.to_s
  visit @link
end
      
When(/^I check groups$/) do

  @link="/group/"
  visit @link
end      
## THEN ##

Then(/^I see the create a group button$/) do
  assert page.has_content?("Create a group")
end

Then(/^I can not see the members$/) do
  assert !page.has_content?("Users")
end

Then(/^I can not see the delete link$/) do
  assert !page.has_link?("Delete group")
end

Then(/^I should see the members$/) do
  assert page.has_content?("Users")
end

Then(/^I should see the delete link$/) do
  assert page.has_link?("Delete group")
end

Then(/^I should see a leave button$/) do
  assert page.has_link?("Leave Group")  
end

Then(/^I should see a join button$/) do
  assert page.has_link?("Join")  
end
