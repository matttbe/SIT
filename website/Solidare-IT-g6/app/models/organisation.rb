class Organisation < ActiveRecord::Base
    validates :name, :presence => true
    has_many :own_services, :class_name => 'Service', :foreign_key => 'org_id'
    has_many :addresses, :class_name => 'Address', :foreign_key => 'orga_id'
    
    belongs_to :creator, :class_name=>'User', :foreign_key=>'creator_id'
end
