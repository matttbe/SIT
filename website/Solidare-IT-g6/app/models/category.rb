class Category < ActiveRecord::Base
  resourcify

  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent'
end
