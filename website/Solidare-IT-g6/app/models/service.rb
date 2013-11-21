class Service < ActiveRecord::Base

  validates :date_start, :presence => true,:date => { :after => Time.now }
  validates :date_end, :presence => true,:date => { :after => :date_start }
  validates :title, :presence => true
  validates :creator_id, :presence => true
  validates :is_demand, :presence => true

  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'org_id'
  has_one :matching_service, :class_name => 'Service', :foreign_key => 'matching_service_id'
  belongs_to :service
end
