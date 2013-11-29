class Address < ActiveRecord::Base

  validates :street, :presence => true
  validates_numericality_of :number, :presence => true,:only_integer => true
  validates_numericality_of :postal_code, :presence => true ,:only_integer => true
  validates :city, :presence => true
  validates :country, :presence => true
  
  #TODO : How to make sure that (at least) one of the two fields is valid and present ?
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'orga_id'

end