class Group < ActiveRecord::Base
	has_many :group_posts
  has_many :group_user_relations
  has_many :users, :through => :group_user_relations

  has_attached_file :photo,
    :storage => :dropbox,
    :dropbox_credentials => DROPBOX_CREDENTIALS,
    :styles => { :medium => "300x300>", :thumb => "32x32>" },
    :path => ":style/group/:id_:filename"
end
