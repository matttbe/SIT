class Follower < ActiveRecord::Base
  has_one :user
  accepts_nested_attributes_for :user
  
  belongs_to :service
  belongs_to :user
  
end
