class Follower < ActiveRecord::Base
  accepts_nested_attributes_for :user
  
  belongs_to :service
  belongs_to :user
  
end
