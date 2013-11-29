class Group < ActiveRecord::Base
	has_many :group_posts
  has_many :group_user_relations
  has_many :users, :through => :group_user_relations
end
