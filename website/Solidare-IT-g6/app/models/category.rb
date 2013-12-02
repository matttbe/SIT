class Category < ActiveRecord::Base
  resourcify

  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent'

  has_many :services, :class_name => 'Service', :foreign_key => 'category_id'

  has_many :childs, :class_name => 'Category', :foreign_key => 'parent'
end
