# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  # config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  # config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  # config.current_user_method = "current_user"
end

Merit::Badge.create!({
  :id=>1,
  :name=>'just-registered',
  :description => "A admin has validated your ID"
  })

Merit::Badge.create!({
  :id=>2,
  :name=>'1-karma',
  :description => "Your karma is greater than 0"
  })

Merit::Badge.create!({
  :id=>3,
  :name=>'5-karma',
  :description => "Your karma is greater than 5"
  })

Merit::Badge.create!({
  :id=>4,
  :name=>'10-karma',
  :description => "Your karma is greater than 10"
  })

Merit::Badge.create!({
  :id=>5,
  :name=>'25-karma',
  :description => "Your karma is greater than 25"
  })

Merit::Badge.create!({
  :id=>6,
  :name=>'50-karma',
  :description => "Your karma is greater than 50"
  })

Merit::Badge.create!({
  :id=>7,
  :name=>'ie6',
  :description => "You are using IE6"
  })

# Create application badges (uses https://github.com/norman/ambry)
#Merit::Badge.create!({
#   id: 1,
#   name: 'just-registered'
# }, {
#   id: 2,
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# })

