class Coworker < ActiveRecord::Base
    belongs_to :user
    belongs_to :organisation
end