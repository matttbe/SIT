class Transaction < ActiveRecord::Base

  has_one :service, :class_name => 'Service', :foreign_key => 'service_id'
  has_one :user, :class_name => 'User', :foreign_key => 'user_id'
end
