class Service < ActiveRecord::Base
  if Rails.env.production?||Rails.env.development?
    include AlgoliaSearch
  end

  validates :date_start, :presence => true,:date => { :after => Time.now }
  validates :date_end, :presence => true,:date => { :after => :date_start }
  validates :title, :presence => true
  validates :creator_id, :presence => true

  belongs_to :user, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :organisation, :class_name => 'Organisation', :foreign_key => 'org_id'

  has_one :transaction, :class_name => 'Transaction', :foreign_key => 'service_id'

  has_one :matching_service, :class_name => 'Service', :foreign_key => 'matching_service_id'
  belongs_to :service

  if Rails.env.production?||Rails.env.development?
    algoliasearch do
      attribute :title, :description
    end
  end
end
