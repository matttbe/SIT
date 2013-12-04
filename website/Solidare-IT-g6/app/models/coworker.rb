class Coworker < ActiveRecord::Base
    belongs_to :user
    belongs_to :organisation

    has_many :managed_users, :class_name => 'User', :foreign_key => 'coworker_id'

end
