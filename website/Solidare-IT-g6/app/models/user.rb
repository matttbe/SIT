class User < ActiveRecord::Base
  before_save :default_values

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :firstname, :presence => true
  validates :birthdate, :presence => true,:date => { :before => Time.now }
  validates :email, :presence => true,:format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  
  has_many :addresses, :class_name => 'Address', :foreign_key => 'user_id'

  has_many :own_services, :class_name => 'Service', :foreign_key => 'creator_id'
  def all_name
    "#{firstname} #{name}"
  end

  def default_values
    self.karma ||= 0
    #self.id_ok||=false
  end

end
