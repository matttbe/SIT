def create_non_valide_user
  @visitor ||= { :email =>"eddy@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 1, :id_ok=>false }
end

When /^I go to admin page$/ do
  visit '/admin'
end

Then /^I should see the Dashboard$/ do
  assert page.has_content?("Dashboard")
end
