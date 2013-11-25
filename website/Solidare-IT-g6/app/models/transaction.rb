class Transaction < ActiveRecord::Base

  validates :feedback_comments, :presence => true
  validates_numericality_of  :feedback_evaluation, :presence => true, :only_integer => true

  has_one :service, :class_name => 'Service', :foreign_key => 'service_id'
  has_one :user, :class_name => 'User', :foreign_key => 'user_id'
end
