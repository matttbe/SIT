class Coworker < ActiveRecord::Base
    belongs_to :user
    belongs_to :organisation, :foreign_key=>'org_id'
end
