def create_service
  @serviceC = {:title=>"Livre",:description => "vente livre congolexicomatisation", :date_start => 'Mon, 28 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => 0, :is_demand=>true, :quick_match=>false,:category_id=>-1}
end

def new_service_offer
  @serviceNew = {:title=>"Livre Réseau",:description => "Livre obo", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id =>0, :is_demand=>false,:quick_match=>false,:category_id=>-1}
end

def new_service
	  @serviceNew = {:title=>"Livre IA",:description => "vente livre IA", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id =>0, :is_demand=>true, :quick_match=>false,:category_id=>-1}
end


def choose_myself_for_service
	@acceptService = AcceptService.where("user_id=:u_id AND service_id=:s_id",:u_id=>@user.id,:s_id=>@service.id).first
	@acceptService.is_chosen_customer = true
	@acceptSerice.save
end

def clear_DB
	$i = 1
	$num = 5

	while $i < $num  do
		@service=Service.where("id=:id",:id=>$i).first
		@service.destroy unless @service.nil?
       		$i+=1
	end
end

def add_service
  find_user
  create_service
  @dl = Service.where("title LIKE :title", :title => @serviceC[:title]).first
  @dl.destroy unless @dl.nil?
  @serviceC[:creator_id] = @user.id
  @service = Service.create!(@serviceC)
end

def add_not_my_service
   @admin=User.where(:email => "maitre@dieu.ciel").first
   new_service
   @serviceNew[:creator_id]=@admin.id
   @service = Service.create!(@serviceNew)
end

def fill_form
  fill_in "service_title", :with => @serviceNew[:title]
  fill_in "service_description", :with => @serviceNew[:description]
  fill_in "service_date_start", :with => 1.days.from_now.strftime('%d/%m/%Y')
  fill_in "service_date_end", :with => 10.days.from_now.strftime('%d/%m/%Y')
end

### GIVEN ###
Given /^The database contains services$/ do
  create_user
  #clear_DB
  add_service
  add_not_my_service
end


Given /^The database contains my services$/ do
  add_service
end


### WHEN ###
When /^I go to the services list$/ do
  click_link "Search a service"
end

When(/^I go to the service_add page$/) do
  visit "services/new"
end

When /^I click on the add service link$/ do
  click_link "Add a service"
end

When(/^I want to create a demand-service$/) do
  new_service
end

When(/^I want to create a offer-service$/) do
  new_service_offer
end

When(/^I fill the service form$/) do
  fill_form
end


When(/^I fill the offer-service form$/) do
  choose('service_is_demand_false')
  fill_form
end



When(/^I fill a wrong date for the end$/) do
  fill_in "service_date_end", :with => 1.years.ago.strftime('%d/%m/%Y')
end


When(/^I fill blank the (.*) fill in the service form$/) do |blank|
  fill_in blank, :with => ""
end

When(/^I visit the page of one service$/) do 
  
  @link="/services/"+@service.id.to_s
  visit @link
end

When(/^I visit the page of my service$/) do 
  add_service
  @link="/services/"+@service.id.to_s
  visit @link
end

When(/^I fill a new title for my service$/) do 
  fill_in "service_title", :with => "new title"
end

When(/^I fill a new date for my service$/) do
  fill_in "service_date_start", :with => 2.days.from_now.strftime('%d/%m/%Y')
end

When(/^I give a feedback$/) do 
  fill_in "transaction_feedback_evaluation", :with => "5"
  fill_in "transaction_feedback_comments", :with => "ok missieur"
  click_button "Give your feedback"
end

When(/^I am the chosen customer for one service$/) do
  choose_myself_for_service
end


### THEN ###

Then(/^I see a service$/) do
  assert page.has_content?(@serviceC[:title])
end


Then(/^I see the add service button$/) do
  assert page.has_content?(:link_or_button, 'Add a service')
end

Then(/^I see adding service message$/) do
  assert page.has_content?("Service was successfully created.")
end

Then(/^I should see a date problem message$/) do
  assert page.has_content?("en.activerecord.errors.models.service.attributes.date_end.after")
end

Then(/^I should see my services$/) do
   assert page.has_content?(@serviceC[:description])
end

Then(/^I should see no services$/) do
   assert page.has_content?("haven't submit services")
end

Then(/^I should see edit and destroy link$/) do
   assert page.has_button?("Edit")
   assert page.has_button?("Destroy")
end

Then(/^I should not see edit and destroy link$/) do
   assert !page.has_button?("Edit | Destroy")
end

Then(/^I should see my service with new title$/) do
   assert page.has_content?("new title")
end

Then(/^I should not see my service$/) do
   assert !page.has_content?(@serviceC[:description])
end

Then(/^I should see services$/) do
   assert page.has_content?(@serviceC[:title])
end

Then(/^I should see the accept link$/) do
   assert page.has_content?(@serviceC[:title])
   assert page.has_button?("Accept")
end

Then(/^I should not see the accept link$/) do
   assert page.has_content?(@serviceC[:title])
   assert !page.has_content?("Accept")
end

Then(/^I should see the service in my services espace$/) do
   assert page.has_content?(@serviceC[:title])
   assert page.has_content?("My services")
end

Then(/^I should see a feedback link$/) do
   assert page.has_content?("How was your experience ? Give a feedback !")
end

Then(/^I should not see a feedback link$/) do
   assert !page.has_content?("How was your experience ? Give a feedback !")
end
