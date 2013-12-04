def add_follower
  $i = 0
  $num = 5

  # get default user
  puts @user.inspect
  puts @service.inspect
  Service.all.each do |s|
    puts s.inspect
  end

  while $i < $num do
    create_visitor
    @visitor[:email] = $i.to_s + @visitor[:email]
    @visitor[:firstname] = $i.to_s

    user = User.where(:email => @visitor[:email]).first
    user.destroy unless user.nil?
    user = User.create!(@visitor)

    f = Follower.where(:service_id => @service.id).where(:user_id => user.id).first
    f.destroy unless f.nil?

    @follow = Follower.new
    @follow[:service_id] = @service.id
    @follow[:user_id] = user.id
    $i += 1
    @follow.save
  end
  @visitor = nil
  create_visitor
  Follower.all.each do |f|
    puts f.inspect
  end
end

### WHEN ###
When /^I visit the page of the services followed$/ do
   visit 'user/following_services'
end

When /^Some users follow my service$/ do
  add_follower
end

When /^I follow a service$/ do
   @admin=User.where(:email => "maitre@dieu.ciel").first
   @service = Service.where("creator_id=:id",:id=>@admin.id).first
   @user = find_user
   @follow = Follower.new
   @follow[:service_id]=@service.id
   @follow[:user_id]=@user.id
   @follow.save

end

When /^The service is finished$/ do
    
end


### THEN ###

Then(/^I should see a follow link$/) do
  assert page.has_link?("Follow")
end

Then(/^I can not see the unfollow link$/) do
  show_page
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
  assert !page.has_content?("No Followers")
end

Then(/^I should see an accept link$/) do
  assert page.has_link?("Accept")
end

Then(/^I can not see the service anymore$/) do
  
end
