# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create! :title => 'No category', :text => 'No Category'

case Rails.env
when "production"
  a1 = User.first
  if a1.nil?
    a1 = User.create! :name => "Admin", :firstname => "Root", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :email => "root@localhost.local", :karma => 0, :id_ok => true, :presentation => "Super Admin", :inscription_ok => true, :password => 'password', :password_confirmation => 'password'
  end
  if not a1.has_role? :superadmin
    a1.add_role :superadmin
  end
else
  # user
  u1 = User.create! :email =>"benoit.baufays@conceptbandb.be", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Baufays", :firstname => "Benoit", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => false, :language => 'fr'
  u2 = User.create! :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => true, :language => 'en',:avatar=>File.open("../../img/profil.jpg")

  # admin
  a1 = User.create! :name => "Admin", :firstname => "Root", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :email => "root@localhost.local", :karma => 0, :id_ok => true, :presentation => "Super Admin", :inscription_ok => true, :password => 'password', :password_confirmation => 'password'
  a1.add_role :superadmin
  a2 = User.create! :email =>"maitre@dieu.ciel", :password=>'password', :password_confirmation=>'password', :name =>"Dieu", :firstname => "Maitre", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => true,:avatar=>File.open("../../img/dieu.jpg")
  a2.add_role :superadmin

  #badge
  u2.add_badge(1)
  a1.add_badge(1)
  a2.add_badge(1)

  # categories
  c1   = Category.create! :title => 'Clothes', :text => 'All clothes'
  c11  = Category.create! :title => 'Pullovers', :text => 'All pullover', :parent_cat => c1
  c111 = Category.create! :title => 'Winter Pullovers', :text => 'All pullover for the winter', :parent_cat => c11
  c112 = Category.create! :title => 'Summer Pullovers', :text => 'All pullover for the summer', :parent_cat => c11
  c2   = Category.create! :title => 'Books', :text => 'All books'
  c22  = Category.create! :title => 'Computer Sciences', :text => 'All books about computer sciences', :parent_cat => c2
  c221 = Category.create! :title => 'Bachelor', :text => 'All books about computer sciences for bachelor', :parent_cat => c22
  c222 = Category.create! :title => 'Master', :text => 'All books about computer sciences for master', :parent_cat => c22


  #addresses

  coo1 = Geokit::Geocoders::GeonamesGeocoder.geocode("Belgium 1341")
  ad1=Address.create! :street => "rue grande", :number => 53, :postal_code=>1341,:city=>"Céroux", :country=>"Belgium", :user_id=>u1.id, :latitude=>coo1.lat, :longitude=> coo1.lng
  coo2 = Geokit::Geocoders::GeonamesGeocoder.geocode("Canada H2A")
  ad2=Address.create! :street => "rue principale", :number => 53, :postal_code=>"H2A",:city=>"Saint Michel", :country=>"Canada", :user_id=>u2.id, :latitude=>coo2.lat, :longitude=> coo2.lng, :principal => true
  coo3 = Geokit::Geocoders::GeonamesGeocoder.geocode("Bulgaria 5029")
  ad3=Address.create! :street => "rue du PSG", :number => 53, :postal_code=>"5029",:city=>"Ajrista", :country=>"Bulgaria", :user_id=>a1.id, :latitude=>coo3.lat, :longitude=> coo3.lng, :principal => true

  # services
  s1 = Service.create! :title=>"Livre",:description => "vente livre congolexicomatisation", :date_start => 'Mon, 28 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2015 15:00:00 UTC +00:00', :creator_id => u2.id, :is_demand=>true, :quick_match=>false, :category_id=>c2.id, :photo=>File.open("../../img/congo.png"), :address_id=>ad2.id
  s2 = Service.create! :title=>"Livre IA",:description => "vente livre IA", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => u1.id, :is_demand=>true, :quick_match=>false, :category_id=>c222.id, :photo=>File.open("../../img/ai.jpg"), :address_id=>ad1.id
  s3 = Service.create! :title=>"Livre Réseau",:description => "vente livre réseau", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2015 15:00:00 UTC +00:00', :creator_id => a1.id, :is_demand=>false, :quick_match=>false, :category_id =>c222.id, :address_id=>ad3.id

  #group
  g1 = Group.create! :name=>"Les mamadous du microcredit", :description => "Trololol", :secret=> false, :private => false

  # Organisation
  o1 = Organisation.create! :name => "Les savant de la rive nord", :creator_id => u2.id
  o2 = Organisation.create! :name => "Les savant de la rive sud", :creator_id => u1.id
  o3 = Organisation.create! :name => "Les savant de la rive ouest", :creator_id => u2.id

  #coworker
  co1=Coworker.create! :organisation_id=>o1.id, :user_id=>u2.id

  # links between classes
  u1.add_role :moderator, c22


  end
