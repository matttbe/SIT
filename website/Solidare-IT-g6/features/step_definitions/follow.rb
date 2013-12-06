def add_follower
  $i = 0
  $num = 5

  creator = User.where(:email => "eddy.malou@savoir.congo").first
  @service = Service.where("creator_id=:id",:id=>creator.id).first

  while $i < $num do
    create_visitor
    @visitor[:email] = $i.to_s + @visitor[:email]
    @visitor[:firstname] = $i.to_s

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
  @link="/services/"+@service.id.to_s
  visit @link
end

def i_follow 
   @admin=User.where(:email => "maitre@dieu.ciel").first
   @service = Service.where("creator_id=:id",:id=>@admin.id).first
   find_user
   @follow = Follower.new
   @follow[:service_id]=@service.id
   @follow[:user_id]=@user.id
   @follow.save  
end

def profil_followers
  find_user
  @service = Service.where(:creator_id => @user.id).first
  @follower = Follower.where(:service_id => @service.id).first
  visit '/user/' + @follower.user_id.to_s  
end

### GIVEN ###

Given /^I follow a service$/ do
  i_follow
end

### WHEN ###

When /^I visit the page of the services followed$/ do
   visit '/following/services'
end

When /^Some users follow my service$/ do
  add_follower
end

When /^The service is finished$/ do
  # ????
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
  if @link == nil
    @link="/services/"+@service.id.to_s
  end
  assert !page.has_link?("Follow", :href => @link+"/follow")
end

Then(/^I can see the followers of my service$/) do
  assert !page.has_content?("No Followers")
end

Then(/^I should see an accept link$/) do
  assert page.has_button?("Accept")
end

Then(/^I can not see the service anymore$/) do
  # ????
end

Then(/^I can see the profiles of my followers$/) do
  profil_followers
end
