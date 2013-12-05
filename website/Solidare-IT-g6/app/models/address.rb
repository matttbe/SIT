class Address < ActiveRecord::Base

  validates :street, :presence => true
  validates_numericality_of :number, :presence => true,:only_integer => true
  validates :postal_code, :presence => true 
  validates :city, :presence => true
  validates :country, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true

  has_many :services, :class_name => 'Service', :foreign_key => 'address_id'
  
  validates :user_id, :presence => true, :if => :orga_present?
  validates :orga_id, :presence => true, :if => :user_present?

  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'orga_id'

  def orga_present?
    self.orga_id.nil?
  end
  
  def user_present?
    self.user_id.nil?
  end

end
