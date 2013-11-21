class Organisation < ActiveRecord::Base
    validates :name, :presence => true
    has_many :own_services, :class_name => 'Service', :foreign_key => 'org_id'
end
