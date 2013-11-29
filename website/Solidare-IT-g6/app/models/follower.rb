class Follower < ActiveRecord::Base
  
  belongs_to :follower
  belongs_to :user
  
end
