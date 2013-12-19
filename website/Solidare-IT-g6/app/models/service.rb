class Service < ActiveRecord::Base

  self.per_page = 10 #10 service per page for infinite scroll
  has_attached_file :photo,
    :storage => :dropbox,
    :dropbox_credentials => DROPBOX_CREDENTIALS,
    :styles => { :medium => "300x300>", :thumb => "64x64>" },
    :default_url => "/assets/64.png",
    :path => ":style/service/:id_:filename"

  validates :date_start, :presence => true,:date => { :after => Time.now }, :if => :new_service?
  validates :date_end, :presence => true,:date => { :after => :date_start }
  validates :title, :presence => true
  validates :creator_id, :presence => true

  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'org_id'

  belongs_to :category, :class_name => 'Category', :foreign_key => 'category_id'

  belongs_to :address
  has_one :transaction, :class_name => 'Transaction', :foreign_key => 'service_id'

  belongs_to :service
  has_one :matching_service, :class_name => 'Service', :foreign_key => 'matching_service_id'
  
  has_many :followers
  has_many :users, through: :followers

  has_many :notifications
  has_many :users, :class_name => 'User', through: :notification
  has_many :accept_services, :class_name => 'AcceptService', :foreign_key => 'service_id'

  def distance(latitude,longitude)
    (self.address.latitude-latitude).abs+(self.address.longitude-longitude).abs
  end

  def new_service?
    new_record?
  end
end
