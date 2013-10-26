class Service < ActiveRecord::Base
  validates :dateStart, :presence => true,:date => { :after => Time.now }
  validates :dateEnd, :presence => true,:date => { :after => :start }
end
