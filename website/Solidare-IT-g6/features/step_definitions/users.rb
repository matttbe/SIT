def create_admin_user
  @visitor ||= { :email =>"maitre@dieu.ciel", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Maitre", :firstname => "Ciel", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>true }
end

def create_non_valide_user
  @visitor ||= { :email =>"eddy@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>false }
end

def create_visitor
  @visitor ||= { :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>true }
end

def show_page
  save_and_open_page
end

def address_default
  coo1 = Geokit::Geocoders::GeonamesGeocoder.geocode("Belgium 1341")
  @address_default||={:street => "rue grande", :number => 53, :postal_code=>1341,:city=>"Céroux", :country=>"Belgium", :latitude=>coo1.lat, :longitude=> coo1.lng}

end

def add_default_address(user)
  address_default
  @address_default[:user_id]=user.id
  @address=Address.new(@address_default)
  @address.save
end


def find_user
  @user ||= User.where(:email => @visitor[:email]).first
end

def find_address(user)
  @address = Address.where(:user_id => user.id).first
end


def find_admin_user
  @admin = User.where(:email => "maitre@dieu.ciel").first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  delete '/users/sign_out'
end

def create_all_users

  @u ||= User.where(:email => "maitre@dieu.ciel").first
  @u.destroy unless @u.nil?
  a = User.create!({:email =>"maitre@dieu.ciel", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Maitre", :firstname => "Ciel", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>true })
  a.add_role "superadmin"
  @u ||= User.where(:email => "eddy@savoir.congo").first
  @u.destroy unless @u.nil?
  User.create!({ :email =>"eddy@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>false })
  @u ||= User.where(:email => "eddy.malou@savoir.congo").first
  @u.destroy unless @u.nil?
  User.create!({ :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>true })
end

def create_user
  create_visitor
  delete_user
  @user = User.create!(@visitor)
end

def create_non_validated_user
  create_non_valide_user
  delete_user
  @user = User.create!(@visitor)
end

def createadmin_user
  create_admin_user
  delete_user
  @user = User.create!(@visitor)
  @user.add_role "superadmin"
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/create_account'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  fill_in "user_firstname", :with => @visitor[:firstname]
  select(2010, :from=> "user_birthdate_1i")
  select('November', :from=>  "user_birthdate_2i")
  select(10, :from=>  "user_birthdate_3i")
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^The DB have a lot of users$/ do
  create_all_users
end
Given /^I am not logged in$/ do
  visit '/users/sign_out' #TODO sign out if I am NOT logged in ?
end

Given /^I log in$/ do
  find_user
  sign_in
end

Given /^All users have a address$/ do
  find_admin_user
  add_default_address(@admin)
  
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I exist as a non validated user$/ do
  create_non_validated_user
end

Given /^I exist as an admin user$/ do
  createadmin_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials for admin user$/ do
  #createadmin_user
  sign_in
end
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "changeme123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_name", :with => "newname"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

When /^I visit a not own address$/ do
  find_admin_user
  find_address(@admin)
  @route="address/"+@address.id.to_s+"/edit"
  visit @route
end

### THEN ###
Then /^I see a return message on sign in page$/ do
  assert page.has_content?("You need to sign in or sign up before continuing.")
end

Then /^I should be signed in$/ do
  assert page.has_content?("Sign out")
  assert !page.has_content?("Sign up")
  assert !page.has_content?("Login")
end

Then /^I should be signed out$/ do
  assert page.has_content?("Sign in")
  assert !page.has_content?("Logout")
end

Then /^I should see a missing password confirmation msg$/ do
  assert page.has_content?("Password confirmation doesn't match Password")
end


Then /^I should see my name$/ do
  create_user
  assert page.has_content?(@user[:name])
end
