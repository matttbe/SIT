class Service < ActiveRecord::Base
  validates :dateStart, :presence => true,:date => { :after => Time.now }
  validates :dateEnd, :presence => true,:date => { :after => :dateStart }

  belongs_to :user
  belongs_to :user
end
