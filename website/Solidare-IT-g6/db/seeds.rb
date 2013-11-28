# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when "production"
  a1=User.create! :name => "Admin", :firstname => "Root", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :email => "root@localhost.local", :karma => 0, :id_ok => true, :presentation => "Super Admin", :inscription_ok => true, :password => 'password', :password_confirmation => 'password', :superadmin => true
else
  u1=User.create! :email =>"benoit.baufays@conceptbandb.be", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Baufays", :firstname => "Benoit", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => false, :language => 'fr'
  u2=User.create! :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => true, :language => 'en'

  a1=User.create! :email =>"maitre@dieu.ciel", :password=>'password', :password_confirmation=>'password', :name =>"Dieu", :firstname => "Maitre", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok => true, :superadmin => true


  s1=Service.create! :title=>"Livre",:description => "vente livre congolexicomatisation", :date_start => 'Mon, 28 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2015 15:00:00 UTC +00:00', :creator_id => u2.id, :is_demand=>true, :quick_match=>false
  s2=Service.create! :title=>"Livre IA",:description => "vente livre IA", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2014 15:00:00 UTC +00:00', :creator_id => u1.id, :is_demand=>true, :quick_match=>false
  s2=Service.create! :title=>"Livre Réseau",:description => "vente livre réseau", :date_start => 'thu, 29 oct 2014 15:00:00 UTC +00:00', :date_end => 'Mon, 4 nov 2015 15:00:00 UTC +00:00', :creator_id => a1.id, :is_demand=>false, :quick_match=>false

  o1=Organisation.create! :name=>"Les joyeux éboueurs de charleroi", :creator_id=>u1.id


end
