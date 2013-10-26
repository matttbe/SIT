# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1=User.create! :email =>"benoit.baufays@conceptbandb.be", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Baufays", :firstname => "Benoit", :birthdate => 'Mon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => true
u2=User.create! :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'Mon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => true


s1=Service.create! :description => "vente livre congolexicomatisation", :dateStart => 'Mon, 28 oct 2013 15:00:00 UTC +00:00', :dateEnd => 'Mon, 4 nov 2013 15:00:00 UTC +00:00', :user_id => u2.id
s2=Service.create! :description => "vente livre IA", :dateStart => 'thu, 29 oct 2013 15:00:00 UTC +00:00', :dateEnd => 'Mon, 4 nov 2013 15:00:00 UTC +00:00', :user_id => u1.id, :customer_id => u1.id