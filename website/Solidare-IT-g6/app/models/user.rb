class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :presence => true
  validates :firstname, :presence => true
  validates :birthdate, :presence => true,:date => { :before => Time.now }
  validates :email, :presence => true,:format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :karma, :presence => true ,:numericality => :only_integer


  def all_name
    "#{firstname} #{name}"
  end

end
