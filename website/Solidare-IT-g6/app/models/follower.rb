class Follower < ActiveRecord::Base
  belongs_to :service, :class_name => 'Service', :foreign_key => 'service_id'
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
end
