class Notification < ActiveRecord::Base  
  
  belongs_to :service
  belongs_to :user
  has_one :user
  
end
