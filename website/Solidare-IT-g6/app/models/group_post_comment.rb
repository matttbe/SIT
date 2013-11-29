class GroupPostComment < ActiveRecord::Base
  belongs_to :group_post
  belongs_to :user
end
