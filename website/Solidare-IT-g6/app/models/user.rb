class User < ActiveRecord::Base
  rolify
  before_save :default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => DROPBOX_CREDENTIALS,
    :styles => { :medium => "300x300>", :thumb => "32x32>" },
    :default_url => "/images/user.png",
    :path => ":style/user/:id_:filename"

  validates :name, :presence => true
  validates :firstname, :presence => true
  validates :birthdate, :presence => true,:date => { :before => Time.now }
  validates :email, :presence => true,:format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  
  has_many :addresses, :class_name => 'Address', :foreign_key => 'user_id'

  has_many :transactions, :class_name => 'Transaction', :foreign_key => 'user_id'
  has_many :own_organisations, :class_name => 'Organisation', :foreign_key => 'creator_id'
  has_many :coworkers
  has_many :organisations,:foreign_key => 'org_id', through: :coworkers
  has_many :own_services, :class_name => 'Service', :foreign_key => 'creator_id'  
  
  has_many :followers
  has_many :services, through: :followers  
  
  has_many :notifications
  has_many :services, through: :notification
  has_many :group_posts, :class_name => 'GroupPost', :foreign_key => 'user_id'

  has_many :group_post_comments, :class_name => 'GroupPostComment', :foreign_key => 'user_id'

  def all_name
    "#{firstname} #{name}"
  end

  def main_address
    if addresses.size==0
      return nil
    end
    @a=addresses.where(:principal=>true)
    if(@a.size==0)
      return addresses.first
    else
      return @a.first
    end

  end

  def default_values
    self.karma ||= 0
    #self.id_ok||=false
  end

  def superadmin
    return self.has_role? "superadmin"
  end

  def superadmin=(newAdmin)
    if newAdmin
      self.add_role "superadmin"
    else
      self.remove_role "superadmin"
    end
  end

end
