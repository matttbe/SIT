class Organisation < ActiveRecord::Base
  resourcify
  validates :name, :presence => true
  has_many :own_services, :class_name => 'Service', :foreign_key => 'org_id'
  has_many :addresses, :class_name => 'Address', :foreign_key => 'orga_id'
  has_many :coworkers
  has_many :users, through: :coworkers
  has_many :managed_user, :class_name => 'User', :foreign_key => 'managed_org_id'
  belongs_to :creator, :class_name=>'User', :foreign_key=>'creator_id'
end
