### WHEN ###

When /^I visit the notifications page$/ do
    visit 'notifications'
end

When /^The service is updated$/ do
    
end

When /^The service is accepted$/ do
    
end

When /^a user accept my service$/ do
    
end

When /^a user follow my service$/ do
   @admin=User.where(:email => "maitre@dieu.ciel").first
   @user = find_user
   @service = Service.where("creator_id=:id",:id=>@user.id).first
   @follow = Follower.new
   @follow[:service_id]=@service.id
   @follow[:user_id]=@admin.id
   @follow.save
   show_page
end

When /^a user unfollow my service$/ do

end


### THEN ###

Then(/^I should see a update notification$/) do
  assert !page.has_content?("was eddited")  
end

Then(/^I should see a accept notification$/) do
   
end

Then(/^I should see a follow notification$/) do
  assert !page.has_content?("was followed")  
end

Then(/^I should see a unfollow notification$/) do
  assert !page.has_content?("was unfollowed")  
end

