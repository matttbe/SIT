class Service < ActiveRecord::Base

  has_attached_file :photo,
    :storage => :dropbox,
    :dropbox_credentials => DROPBOX_CREDENTIALS,
    :styles => { :medium => "300x300>", :thumb => "64x64>" },
    :default_url => "/assets/64.png",
    :path => ":style/service/:id_:filename"

  validates :date_start, :presence => true,:date => { :after => Time.now }
  validates :date_end, :presence => true,:date => { :after => :date_start }
  validates :title, :presence => true
  validates :creator_id, :presence => true

  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'org_id'

  belongs_to :category, :class_name => 'Category', :foreign_key => 'category_id'

  has_one :transaction, :class_name => 'Transaction', :foreign_key => 'service_id'

  belongs_to :service
  has_one :matching_service, :class_name => 'Service', :foreign_key => 'matching_service_id'
  
  has_many :followers
  has_many :users, through: :followers

  has_many :notifications
  has_many :users, through: :notification
end
