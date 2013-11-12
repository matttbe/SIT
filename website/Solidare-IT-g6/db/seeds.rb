# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1=User.create! :email =>"benoit.baufays@conceptbandb.be", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Baufays", :firstname => "Benoit", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0,:id_ok => false
u2=User.create! :email =>"eddy.malou@savoir.congo", :password=>'iloveponcin', :password_confirmation=>'iloveponcin', :name =>"Malou", :firstname => "Eddy", :birthdate => 'TMon, 18 Jun 1990 15:00:00 UTC +00:00', :karma => 0, :id_ok=> true
