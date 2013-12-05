class GroupPost < ActiveRecord::Base
  belongs_to :group
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'

  has_many :group_post_comments, :dependent => :destroy
end
